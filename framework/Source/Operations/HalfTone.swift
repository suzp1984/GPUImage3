public class Halftone: CustomOperation {
    public var uniform: HalfToneUniform!
    
    public init() {
        super.init(fragmentFunctionName:"halftoneFragment", numberOfInputs:1)
        
        uniform = HalfToneUniform(fractionalWidthOfPixel: 0.01, aspectRatio: 1.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<HalfToneUniform>.stride)
        }
    }
}
