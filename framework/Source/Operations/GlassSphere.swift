public class GlassSphereRefraction: BasicOperation {
    public var radius:Float = 0.25 { didSet { uniformSettings["radius"] = radius } }
    public var refractiveIndex:Float = 0.71 { didSet { uniformSettings["refractiveIndex"] = refractiveIndex } }
    public var center:Position = Position.center { didSet { uniformSettings["center"] = center } }
    
    public init() {
        super.init(fragmentFunctionName:"glassSphereFragment", numberOfInputs:1)
        
        ({radius = 0.25})()
        ({refractiveIndex = 0.71})()
        ({center = Position.center})()
        
        uniformSettings.setUniformStride(byCountOfFloats: 6)
//        self.backgroundColor = Color(red:0.0, green:0.0, blue:0.0, alpha:0.0)
    }
}
