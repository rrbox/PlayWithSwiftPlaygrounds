import SpriteKit
class SUIButtonSensor: SKSpriteNode {
    var part: SUIPart?
    var isTouched = false
    var isSelected = false
    var selectAction = SKAction.scale(to: 1.5, duration: 0.01)
    var cancelAction = SKAction.scale(to: 1.0, duration: 0.01)
    var selectEndAction = SKAction.sequence([
        SKAction.scale(to: 0.8, duration: 0.05),
        SKAction.scale(to: 1.0, duration: 0.01)
    ])
    func select() {
        if !self.isSelected {
            self.part?.run(self.selectAction)
            self.isSelected = true
        }
    }
    func cancel() {
        if self.isSelected {
            self.part?.run(self.cancelAction)
            self.isSelected = false
        }
    }
    func touchDown() {
        self.part?.removeAllActions()
        self.part?.run(self.selectAction)
        self.isTouched = true
        self.isSelected = true
        self.part?.touchDownHandler()
    }
    func touchMoved(toPoint pos: CGPoint) {
        var selected: Bool {
            return self.parent!.atPoint(pos) == self
        }
        if selected {
            self.select()
        } else {
            self.cancel()
        }
    }
    func touchUp() {
        if self.isSelected {
            self.removeAllActions()
            self.part?.run(SKAction.sequence([
                self.selectEndAction,
                SKAction.run {
                    self.isSelected = false
                    self.part?.touchUpHandler()
                }
            ]))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchDown()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.touchMoved(toPoint: touch.location(in: self.parent!))
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchUp()
    }
}
open class SUIPart: SKNode {
    public var touchDownHandler: () -> () = {}
    public var touchUpHandler: () -> () = {}
}
open class SUIButton: SUIPart {
    var sensor: SUIButtonSensor?
    public var isTouched: Bool? {
        return self.sensor?.isTouched
    }
    public init(size: CGSize) {
        super.init()
        self.sensor = SUIButtonSensor(color: .white, size: size)
        if let s = self.sensor {
            s.isUserInteractionEnabled = true
            self.addChild(s)
            s.zPosition = 1000
            s.part = self
            s.alpha = 0.01
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

