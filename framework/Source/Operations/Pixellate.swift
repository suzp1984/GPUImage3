public class Pixellate: CustomOperation {
    public var uniform: PixellateUniform!
    
    public init() {
        super.init(fragmentFunctionName:"pixellateFragment", numberOfInputs:1)
        
        uniform = PixellateUniform(fractionalWidthOfPixel: 0.01, aspectRatio: 1.0)
        uniformHandler = processUniforms(handler:)
    }

    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<PixellateUniform>.stride)
        }
    }
}
