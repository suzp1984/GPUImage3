public class LuminanceThreshold: CustomOperation {
    public var uniform: ThresholdUniform!
    
    public init() {
        super.init(fragmentFunctionName: "thresholdFragment", numberOfInputs:1)
        
        uniform = ThresholdUniform(threshold: 0.5)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<ThresholdUniform>.stride)
        }
    }
}
