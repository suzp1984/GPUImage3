public class ThresholdSobelEdgeDetection: CustomeTextureSamplingOperation {
    public var uniform: ThresholdSobelEdgeUniform!
    
    public init() {
        super.init(fragmentFunctionName:"thresholdSobelEdgeDetectionFragment", numberOfInputs:1)
        
        uniform = ThresholdSobelEdgeUniform(edgeStrength: 1.0, threshold: 0.25)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<ThresholdSobelEdgeUniform>.stride)
        }
    }
}
