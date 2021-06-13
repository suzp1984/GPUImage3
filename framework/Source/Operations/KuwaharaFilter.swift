public class KuwaharaFilter: CustomOperation {
    public var uniform: KuwaharaUniform!
    
    public init() {
        super.init(fragmentFunctionName:"kuwaharaFragment", numberOfInputs:1)
        
        uniform = KuwaharaUniform(radius: 3.0)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<KuwaharaUniform>.stride)
        }
    }
}
