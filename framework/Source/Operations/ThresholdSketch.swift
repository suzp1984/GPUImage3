public class ThresholdSketchFilter: CustomeTextureSamplingOperation {
    public var uniform: ThresholdSketchUniform!
    
    public init() {
        super.init(fragmentFunctionName:"thresholdSketchFragment", numberOfInputs:1)
        
        uniform = ThresholdSketchUniform(edgeStrength: 1.0, threshold: 0.25)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<ThresholdSketchUniform>.stride)
        }
    }
}
