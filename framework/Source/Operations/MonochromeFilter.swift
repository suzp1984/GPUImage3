public class MonochromeFilter: CustomOperation {
    public var uniform: MonochromeUniform!
    
    public init() {
        super.init(fragmentFunctionName:"monochromeFragment", numberOfInputs:1)
        
        uniform = MonochromeUniform(intensity: 1.0, filterColor: vector_float3(0.6, 0.45, 0.3))
        
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<MonochromeUniform>.stride)
        }
    }
}

