public class GammaAdjustment: CustomOperation {
    
    public var uniform: GammaUniform!
    
    public init() {
        super.init(fragmentFunctionName:"gammaFragment", numberOfInputs:1)
        
        uniform = GammaUniform(gamma: 1.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<GammaUniform>.stride)
        }
    }
}
