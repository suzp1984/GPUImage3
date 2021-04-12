public class SaturationAdjustment: CustomOperation {
    
    public var uniform: SaturationUniform = SaturationUniform(saturation: 1.0)
       
    public init() {
        super.init(fragmentFunctionName:"saturationFragment", numberOfInputs:1)
                
        uniformHandler = processUniforms(handler:)

    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<SaturationUniform>.stride)
        }
    }
    
}
