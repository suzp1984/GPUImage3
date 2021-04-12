public class ExposureAdjustment: CustomOperation {
    public var uniform: ExposureUniform!
    
    public init() {
        super.init(fragmentFunctionName:"exposureFragment", numberOfInputs:1)
        
        uniform = ExposureUniform(exposure: 0.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<ExposureUniform>.stride)
        }
    }
}
