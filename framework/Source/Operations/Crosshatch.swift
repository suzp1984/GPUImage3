public class Crosshatch: CustomOperation {
    public var uniform: CrosshatchUniform!
    
    public init() {
        super.init(fragmentFunctionName:"crosshatchFragment", numberOfInputs:1)
        
        uniform = CrosshatchUniform(crossHatchSpacing: 0.03, lineWidth: 0.003)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<CrosshatchUniform>.stride)
        }
    }
}
