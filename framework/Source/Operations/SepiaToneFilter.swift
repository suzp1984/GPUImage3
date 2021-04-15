public class SepiaToneFilter: ColorMatrixFilter {
    override public init() {
        super.init()
        
//        uniform.colorMatrix = matrix_float4x4(columns: (vector_float4(0.3588, 0.2990, 0.2392, 0.0),
//                                                        vector_float4(0.7044, 0.5870, 0.4696, 0.0),
//                                                        vector_float4(0.1368, 0.1140, 0.0912, 0.0),
//                                                        vector_float4(0.0,    0.0,    0.0,    1.0)))
        
        uniform.colorMatrix = matrix_float4x4(columns: (vector_float4(0.3588, 0.7044, 0.1368, 0.0),
                                                        vector_float4(0.2990, 0.5870, 0.1140, 0.0),
                                                        vector_float4(0.2392, 0.4696, 0.0912, 0.0),
                                                        vector_float4(0.0,    0.0,    0.0,    1.0)))
    }
}
