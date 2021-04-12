public class BrightnessAdjustment: CustomOperation {
    public var uniform: BrightnessUniform!
    
    public init() {
        super.init(fragmentFunctionName:"brightnessFragment", numberOfInputs:1)
        
        uniform = BrightnessUniform(brightness: 0.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<BrightnessUniform>.stride)
        }
    }
}
