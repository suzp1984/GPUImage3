public class SobelEdgeDetection: CustomeTextureSamplingOperation {
    public var uniform: SobelEdgeDetectionUniform!
    
    public init() {
        super.init(fragmentFunctionName:"sobelEdgeDetectionFragment", numberOfInputs:1)
        
        uniform = SobelEdgeDetectionUniform(edgeStrength: 1.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<SobelEdgeDetectionUniform>.stride)
        }
    }
}
