public class FalseColor: CustomOperation {
    public var uniform: FalseColorUniform!
    
    public init() {
        super.init(fragmentFunctionName:"falseColorFragment", numberOfInputs:1)
        
        uniform = FalseColorUniform(firstColor: vector_float4(0.0, 0.0, 0.5, 1.0),
                                    secondColor: vector_float4(1.0, 0.0, 0.0, 1.0))
        
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<FalseColorUniform>.stride)
        }
    }
}
