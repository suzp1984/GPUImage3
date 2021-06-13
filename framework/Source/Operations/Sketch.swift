public class SketchFilter: CustomeTextureSamplingOperation {
    public var uniform: SketchUniform!
    
    public init() {
        super.init(fragmentFunctionName:"sketchFragment", numberOfInputs:1)
        
        uniform = SketchUniform(edgeStrength: 1.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<SketchUniform>.stride)
        }
    }
}
