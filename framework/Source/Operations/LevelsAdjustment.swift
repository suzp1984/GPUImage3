public class LevelsAdjustment: CustomOperation {
    public var uniform: LevelAdjustmentUniform!
    
    // TODO: Is this an acceptable interface, or do I need to bring this closer to the old implementation?
    
    public init() {
        super.init(fragmentFunctionName: "levelsFragment", numberOfInputs: 1)
        
        uniform = LevelAdjustmentUniform(minimum: vector_float3(0.0, 0.0, 0.0),
                                         middle: vector_float3(1.0, 1.0, 1.0),
                                         maximum: vector_float3(1.0, 1.0, 1.0),
                                         minOutput: vector_float3(0.0, 0.0, 0.0),
                                         maxOutput: vector_float3(1.0, 1.0, 1.0))
        uniformHandler = processUniforms(handler:)
    }
    
    func processUniforms(handler: (UnsafeRawPointer, Int) -> Void) -> Void {
        withUnsafePointer(to: uniform) {
            handler($0, MemoryLayout<LevelAdjustmentUniform>.stride)
        }
    }
}
