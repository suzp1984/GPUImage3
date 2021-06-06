public class PolkaDot: CustomOperation {
    public var uniform: PolkaDotUniform!
    
    public init() {
        super.init(fragmentFunctionName:"polkaDotFragment", numberOfInputs:1)
        
        uniform = PolkaDotUniform(dotScaling: 0.90, fractionalWidthOfPixel: 0.01, aspectRatio: 1.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<PolkaDotUniform>.stride)
        }
    }
}
