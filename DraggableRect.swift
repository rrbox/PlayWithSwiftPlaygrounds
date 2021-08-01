import SpriteKit
open class DraggableRect: SKSpriteNode {
    //自身がタッチされた時の処理を書きます.
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeAllActions()
        //自身を手前に表示します.
        self.zPosition = 1
        //タッチにより, 巨大化させます. ついでに色も変えます.
        self.run(SKAction.group([
            SKAction.scale(to: 1.5, duration: 0.05),
            SKAction.colorize(with: .white, colorBlendFactor: 0, duration: 0.5)
        ]))
    }
    //自身がドラッグされた時の処理を書きます.
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //ドラッグによって持ち運べるようにします.
            self.position = touch.location(in: self.parent!)
        }
    }
    //自身へのタッチが終了した時の処理を書きます.
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //巨大化した自分自身の大きさを元に戻します. 色も戻し, 最後にzPositionを戻します.
        self.removeAllActions()
        self.run(SKAction.group([
            SKAction.scale(to: 1.0, duration: 0.05),
            SKAction.sequence([
                SKAction.colorize(with: .darkGray, colorBlendFactor: 0, duration: 0.5),
                SKAction.run {
                    self.zPosition = 0
                }
            ]),
        ]))
    }
}
