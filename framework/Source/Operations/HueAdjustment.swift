public class HueAdjustment: CustomOperation {
    public var uniform: HueUniform!
        
    public init() {
        super.init(fragmentFunctionName:"hueFragment", numberOfInputs:1)
        
        uniform = HueUniform(hue: 90.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<HueUniform>.stride)
        }
    }
}
