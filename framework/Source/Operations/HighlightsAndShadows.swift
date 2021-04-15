public class HighlightsAndShadows: CustomOperation {
    
    public var uniform: HighlightShadowUniform!
    
    public init() {
        super.init(fragmentFunctionName:"highlightShadowFragment", numberOfInputs:1)
        
        uniform = HighlightShadowUniform(shadows: 0.0, highlights: 1.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<HighlightShadowUniform>.stride)
        }
    }
}
