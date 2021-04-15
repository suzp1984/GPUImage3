public class Solarize: CustomOperation {
    public var uniform: SolarizeUniform!
    
    public init() {
        super.init(fragmentFunctionName: "solarizeFragment", numberOfInputs:1)

        uniform = SolarizeUniform(threshold: 0.5)
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<SolarizeUniform>.stride)
        }
    }
}
