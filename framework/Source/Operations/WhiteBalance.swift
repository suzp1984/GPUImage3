
public class WhiteBalance: CustomOperation {
    public var uniform: WhiteBalanceUniform!
    
    public init() {
        super.init(fragmentFunctionName:"whiteBalanceFragmentShader", numberOfInputs:1)
        
        uniform = WhiteBalanceUniform(temperature: 0.0, tint: 1.0)

        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<WhiteBalanceUniform>.stride)
        }
    }
}

