public class Vignette: CustomOperation {
    public var uniform: VignetteUniform!
    
    public init() {
        super.init(fragmentFunctionName:"vignetteFragment", numberOfInputs:1)
        
        uniform = VignetteUniform(vignetteCenter: vector_float2(0.5, 0.5),
                                  vignetteColor: vector_float3(0.0, 0.0, 0.0),
                                  vignetteStart: 0.3,
                                  vignetteEnd: 0.75)
        
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<VignetteUniform>.stride)
        }
    }
}
