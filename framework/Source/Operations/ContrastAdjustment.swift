public class ContrastAdjustment: CustomOperation {
    
    public var uniform: ContrastUniform!
        
    public init() {
        super.init(fragmentFunctionName:"contrastFragment", numberOfInputs:1)
        
        uniform = ContrastUniform(contrast: 1.0)
        
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<ContrastUniform>.stride)
        }
    }
}
