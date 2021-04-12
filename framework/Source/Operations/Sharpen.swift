public class Sharpen: CustomOperation {
    public var uniform: SharpenUniform!
    
    public init() {
        super.init(fragmentFunctionName: "sharpenFragment", numberOfInputs: 1)
        
        uniform = SharpenUniform(sharpness: 0.0, textureWidth: 400.0, textureHeight: 400.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<SharpenUniform>.stride)
        }
    }
    
    public override var isUniformNeedTextureSize: Bool { get {return true } }
    
    public override func setUniformTextureSize(width: Float, height: Float) {
        uniform.textureWidth = width
        uniform.textureHeight = height
    }
}
