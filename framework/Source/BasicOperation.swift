import Foundation
import Metal

public func defaultVertexFunctionNameForInputs(_ inputCount:UInt) -> String {
    switch inputCount {
    case 1:
        return "oneInputVertex"
    case 2:
        return "twoInputVertex"
    default:
        return "oneInputVertex"
    }
}

open class AbstractOperation: ImageProcessingOperation {
    public let maximumInputs: UInt
    public let targets = TargetContainer()
    public let sources = SourceContainer()
    
    public var activatePassthroughOnNextFrame: Bool = false
    public var useMetalPerformanceShaders: Bool = false {
        didSet {
            if !sharedMetalRenderingDevice.metalPerformanceShadersAreSupported {
                print("Warning: Metal Performance Shaders are not supported on this device")
                useMetalPerformanceShaders = false
            }
        }
    }

    let renderPipelineState: MTLRenderPipelineState
    let operationName: String
    var inputTextures = [UInt:Texture]()
    let textureInputSemaphore = DispatchSemaphore(value:1)
    var useNormalizedTextureCoordinates = true
    var metalPerformanceShaderPathway: ((MTLCommandBuffer, [UInt:Texture], Texture) -> ())?

    public init(vertexFunctionName: String? = nil, fragmentFunctionName: String, numberOfInputs: UInt = 1, operationName: String = #file) {
        self.maximumInputs = numberOfInputs
        self.operationName = operationName
        
        let concreteVertexFunctionName = vertexFunctionName ?? defaultVertexFunctionNameForInputs(numberOfInputs)
        let (pipelineState, _) = generateRenderPipelineState(device:sharedMetalRenderingDevice,
                                                             vertexFunctionName:concreteVertexFunctionName,
                                                             fragmentFunctionName:fragmentFunctionName,
                                                             operationName:operationName)
        self.renderPipelineState = pipelineState
    }
    
    public func transmitPreviousImage(to target: ImageConsumer, atIndex: UInt) {
        // TODO: Finish implementation later
    }
    
    public func newTextureAvailable(_ texture: Texture, fromSourceIndex: UInt) {
        let _ = textureInputSemaphore.wait(timeout:DispatchTime.distantFuture)
        defer {
            textureInputSemaphore.signal()
        }
        
        inputTextures[fromSourceIndex] = texture
        
        if (UInt(inputTextures.count) >= maximumInputs) || activatePassthroughOnNextFrame {
            let outputWidth:Int
            let outputHeight:Int
            
            let firstInputTexture = inputTextures[0]!
            if firstInputTexture.orientation.rotationNeeded(for:.portrait).flipsDimensions() {
                outputWidth = firstInputTexture.texture.height
                outputHeight = firstInputTexture.texture.width
            } else {
                outputWidth = firstInputTexture.texture.width
                outputHeight = firstInputTexture.texture.height
            }
            
            guard let commandBuffer = sharedMetalRenderingDevice.commandQueue.makeCommandBuffer() else {return}

            let outputTexture = Texture(device:sharedMetalRenderingDevice.device, orientation: .portrait, width: outputWidth, height: outputHeight, timingStyle: firstInputTexture.timingStyle)
            
            guard (!activatePassthroughOnNextFrame) else { // Use this to allow a bootstrap of cyclical processing, like with a low pass filter
                activatePassthroughOnNextFrame = false
                // TODO: Render rotated passthrough image here
                
                removeTransientInputs()
                textureInputSemaphore.signal()
                updateTargetsWithTexture(outputTexture)
                let _ = textureInputSemaphore.wait(timeout:DispatchTime.distantFuture)

                return
            }
            
            if let alternateRenderingFunction = metalPerformanceShaderPathway, useMetalPerformanceShaders {
                var rotatedInputTextures: [UInt:Texture]
                if (firstInputTexture.orientation.rotationNeeded(for:.portrait) != .noRotation) {
                    let rotationOutputTexture = Texture(device:sharedMetalRenderingDevice.device, orientation: .portrait, width: outputWidth, height: outputHeight)
                    guard let rotationCommandBuffer = sharedMetalRenderingDevice.commandQueue.makeCommandBuffer() else {return}
                    
                    render(commandBuffer: rotationCommandBuffer,
                           pipelineState: sharedMetalRenderingDevice.passthroughRenderState,
                           inputTextures: inputTextures,
                           useNormalizedTextureCoordinates: useNormalizedTextureCoordinates,
                           outputTexture: rotationOutputTexture)
                    
                    rotationCommandBuffer.commit()
                    rotatedInputTextures = inputTextures
                    rotatedInputTextures[0] = rotationOutputTexture
                } else {
                    rotatedInputTextures = inputTextures
                }
                alternateRenderingFunction(commandBuffer, rotatedInputTextures, outputTexture)
            } else {
                render(commandBuffer: commandBuffer,
                       pipelineState: renderPipelineState,
                       inputTextures: inputTextures,
                       useNormalizedTextureCoordinates: useNormalizedTextureCoordinates,
                       outputTexture: outputTexture)
                
            }
            commandBuffer.commit()
            
            removeTransientInputs()
            textureInputSemaphore.signal()
            updateTargetsWithTexture(outputTexture)
            let _ = textureInputSemaphore.wait(timeout:DispatchTime.distantFuture)
        }
    }
    
    open func render(commandBuffer: MTLCommandBuffer,
                pipelineState: MTLRenderPipelineState,
                inputTextures: [UInt:Texture],
                useNormalizedTextureCoordinates: Bool,
                outputTexture: Texture) -> Void {
        fatalError("need to override")
    }
    
    func removeTransientInputs() {
        for index in 0..<self.maximumInputs {
            if let texture = inputTextures[index], texture.timingStyle.isTransient() {
                inputTextures[index] = nil
            }
        }
    }
}

open class CustomOperation: AbstractOperation {
    var uniformHandler: (((UnsafeRawPointer, Int) -> Void) -> Void)? = nil
    
    public init(vertexFunctionName: String? = nil,
                fragmentFunctionName: String,
                numberOfInputs: UInt = 1,
                uniformHandler: (((UnsafeRawPointer, Int) -> Void) -> Void)? = nil,
                operationName: String = #file) {
        super.init(vertexFunctionName: vertexFunctionName,
                   fragmentFunctionName: fragmentFunctionName,
                   numberOfInputs: numberOfInputs,
                   operationName: operationName)
        
        self.uniformHandler = uniformHandler
    }
    
    open var isUniformNeedAspectRatio: Bool { get { return false} }
    
    open func setUniformAspectRatio(ratio: Float) {
    }
    
    open override func render(commandBuffer: MTLCommandBuffer,
                              pipelineState: MTLRenderPipelineState,
                              inputTextures: [UInt : Texture],
                              useNormalizedTextureCoordinates: Bool,
                              outputTexture: Texture) {
        if let uniformHandler = uniformHandler {
            uniformHandler { uniformPtr, length in
                
                if isUniformNeedAspectRatio {
                    let firstInputTexture = inputTextures[0]!
                    let outputRotation = firstInputTexture.orientation.rotationNeeded(for:.portrait)
                    setUniformAspectRatio(ratio: firstInputTexture.aspectRatio(for: outputRotation))
                }
                
                commandBuffer.renderQuad(pipelineState: pipelineState,
                                         uniformPtr: uniformPtr,
                                         uniformDataLength: length,
                                         inputTextures: inputTextures,
                                         useNormalizedTextureCoordinates: useNormalizedTextureCoordinates,
                                         outputTexture: outputTexture)
            }
        }
    }
}

open class BasicOperation: AbstractOperation {
    
    public var uniformSettings:ShaderUniformSettings!

    public override init(vertexFunctionName: String? = nil,
                fragmentFunctionName: String,
                numberOfInputs: UInt = 1,
                operationName: String = #file) {
        
        super.init(vertexFunctionName: vertexFunctionName,
                   fragmentFunctionName: fragmentFunctionName,
                   numberOfInputs: numberOfInputs,
                    operationName: operationName)
        
            let concreteVertexFunctionName = vertexFunctionName ?? defaultVertexFunctionNameForInputs(numberOfInputs)

            let (_, lookupTable) = generateRenderPipelineState(device:sharedMetalRenderingDevice, vertexFunctionName:concreteVertexFunctionName, fragmentFunctionName:fragmentFunctionName, operationName:operationName)
            self.uniformSettings = ShaderUniformSettings(uniformLookupTable:lookupTable)
        
    }
    
    open override func render(commandBuffer: MTLCommandBuffer,
                         pipelineState: MTLRenderPipelineState,
                         inputTextures: [UInt : Texture],
                         useNormalizedTextureCoordinates: Bool,
                         outputTexture: Texture) {
        
        
        if uniformSettings.usesAspectRatio {
            let firstInputTexture = inputTextures[0]!
            let outputRotation = firstInputTexture.orientation.rotationNeeded(for:.portrait)
            uniformSettings["aspectRatio"] = firstInputTexture.aspectRatio(for: outputRotation)
        }
        
        commandBuffer.renderQuad(pipelineState: pipelineState,
                                 uniformSettings: uniformSettings,
                                 inputTextures: inputTextures,
                                 useNormalizedTextureCoordinates: useNormalizedTextureCoordinates,
                                 outputTexture: outputTexture)
    }
}
