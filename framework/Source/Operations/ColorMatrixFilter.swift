public class ColorMatrixFilter: CustomOperation {
    
    public var uniform: ColorMatrixUniform!
    
    public init() {
        
        super.init(fragmentFunctionName:"colorMatrixFragment", numberOfInputs:1)
        
        uniform = ColorMatrixUniform(intensity: 1.0, colorMatrix: matrix_identity_float4x4)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<ColorMatrixUniform>.stride)
        }
    }
}
