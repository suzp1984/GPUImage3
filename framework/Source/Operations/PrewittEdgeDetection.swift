public class PrewittEdgeDetection: CustomeTextureSamplingOperation {
    public var uniform: PrewittEdgeDetectionUniform!
    
    public init() {
        super.init(fragmentFunctionName:"prewittEdgeDetectionFragment", numberOfInputs:1)
        
        uniform = PrewittEdgeDetectionUniform(edgeStrength: 1.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<PrewittEdgeDetectionUniform>.stride)
        }
    }
}
