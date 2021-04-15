public class SoftElegance: OperationGroup {
    let lookup1 = LookupFilter()
    let lookup2 = LookupFilter()
    let gaussianBlur = GaussianBlur()
    let alphaBlend = AlphaBlend()
    
    public var intensity: Float! {
        didSet {
            lookup1.uniform.intensity = intensity
            lookup2.uniform.intensity = intensity
        }
    }
    public override init() {
        super.init()
        
        self.configureGroup{input, output in
            self.lookup1.lookupImage = PictureInput(imageName:"lookup_soft_elegance_1.png")
            self.lookup2.lookupImage = PictureInput(imageName:"lookup_soft_elegance_2.png")
            self.gaussianBlur.blurRadiusInPixels = 10.0
            self.alphaBlend.mix = 0.14
            
            input --> self.lookup1 --> self.alphaBlend --> self.lookup2 --> output
            self.lookup1 --> self.gaussianBlur --> self.alphaBlend
        }
    }
}
