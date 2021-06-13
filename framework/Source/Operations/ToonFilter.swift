public class ToonFilter: CustomeTextureSamplingOperation {
    public var uniform: ToonUniform!
    
    public init() {
        super.init(fragmentFunctionName:"toonFragment", numberOfInputs:1)
        
        uniform = ToonUniform(threshold: 0.2, quantizationLevels: 10.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<ToonUniform>.stride)
        }
    }
}
