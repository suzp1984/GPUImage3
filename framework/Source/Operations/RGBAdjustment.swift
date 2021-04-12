public class RGBAdjustment: CustomOperation {
    public var uniform: RGBAdjustmentUniform!
    
    public init() {
        super.init(fragmentFunctionName:"rgbAdjustmentFragment", numberOfInputs:1)
        
        uniform = RGBAdjustmentUniform(redAdjustment: 1.0,
                                       greenAdjustment: 1.0,
                                       blueAdjustment: 1.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<RGBAdjustmentUniform>.stride)
        }
    }
}
