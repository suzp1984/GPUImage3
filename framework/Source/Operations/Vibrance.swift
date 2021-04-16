public class Vibrance: CustomOperation {
    public var uniform: VibranceUniform!
    
    public init() {
        super.init(fragmentFunctionName:"vibranceFragment", numberOfInputs:1)
        
        uniform = VibranceUniform(vibrance: 0.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<VibranceUniform>.stride)
        }
    }
}
