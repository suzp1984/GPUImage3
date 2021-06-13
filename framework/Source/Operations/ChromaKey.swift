public class ChromaKeying: CustomOperation {
    public var uniform: ChromaKeyUniform!
    
    public init() {
        super.init(fragmentFunctionName:"ChromaKeyFragment", numberOfInputs:1)
        
        uniform = ChromaKeyUniform(thresholdSensitivity: 0.4,
                                   smoothing: 0.1,
                                   colorToReplace: vector_float4(0.0, 1.0, 0.0, 1.0))
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<ChromaKeyUniform>.stride)
        }
    }
}
