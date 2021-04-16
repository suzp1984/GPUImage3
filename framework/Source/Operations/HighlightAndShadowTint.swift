public class HighlightAndShadowTint: CustomOperation {
    
    public var uniform: HighlightShadowTintUniform!
    
    public init() {
        super.init(fragmentFunctionName:"highlightShadowTintFragment", numberOfInputs:1)

        uniform = HighlightShadowTintUniform(shadowTintIntensity: 0.0,
                                             highlightTintIntensity: 0.0,
                                             shadowTintColor: vector_float3(1.0, 0.0, 0.0),
                                             highlightTintColor: vector_float3(0.0, 0.0, 1.0))
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<HighlightShadowTintUniform>.stride)
        }
    }
}
