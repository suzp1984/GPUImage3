public class ZoomBlur: CustomOperation {
    public var uniform: ZoomBlurUniform!
    
    public init() {
        super.init(fragmentFunctionName:"zoomBlurFragment", numberOfInputs:1)
        
        uniform = ZoomBlurUniform(center: vector_float2(0.5, 0.5), size: 1.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<ZoomBlurUniform>.stride)
        }
    }
}
