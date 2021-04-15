public class Haze: CustomOperation {
    
    public var uniform: HazeUniform!
    
    public init() {
        super.init(fragmentFunctionName:"hazeFragment", numberOfInputs:1)
        
        uniform = HazeUniform(hazeDistance: 0.2, slope: 0.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<HazeUniform>.stride)
        }
    }
}
