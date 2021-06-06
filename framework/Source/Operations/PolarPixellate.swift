// Issues with Size not working with the compiler
public class PolarPixellate: CustomOperation {
    public var uniform: PolarPixellateUniform!
    
    public init() {
        super.init(fragmentFunctionName:"polarPixellateFragment", numberOfInputs:1)
        
        uniform = PolarPixellateUniform(pixelSize: vector_float2(0.05, 0.05),
                                        center: vector_float2(0.5, 0.5))
        uniformHandler = processUniforms(handler:)
    }

    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<PolarPixellateUniform>.stride)
        }
    }
}
