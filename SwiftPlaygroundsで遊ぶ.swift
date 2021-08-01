
import PlaygroundSupport
import SpriteKit

//画面に配置するSpriteNodeを設計します.

//Sceneを設計します.
class MyGameScene: SKScene {
    var allRect: [DraggableRect] = []
    func veryRandomMap() -> [[Int]] {
        var map: [[Int]] = []
        var a = [0, 1, 2, 3, 4]
        for i in 1 ... 10 {
            var m: [Int] = []
            for i in 1 ... 10 {
                if let e = a.randomElement() {
                    m.append(e)
                }
            }
            map.append(m)
        }
        return map
    }
    func makeRect(_ color: SKColor, atPoint pos: CGPoint) -> DraggableRect {
        let rect = DraggableRect(color: color, size: CGSize(width: 32, height: 32))
        self.allRect.append(rect)
        rect.isUserInteractionEnabled = true
        rect.position = pos
        return rect
    }
    
    func make(_ map: [[Int]]?) {
        guard let m = map else { fatalError("おい. 何やっとんじゃボケ.") }
        var yPos = 32*5
        var xPos = -32*5
        for y in m {
            for x in y {
                switch x {
                case 1:
                    self.addChild(self.makeRect(.systemRed, atPoint: CGPoint(x: xPos, y: yPos)))
                case 2:
                    self.addChild(self.makeRect(.red, atPoint: CGPoint(x: xPos, y: yPos)))
                case 3:
                    self.addChild(self.makeRect(.systemBlue, atPoint: CGPoint(x: xPos, y: yPos)))
                case 4:
                    self.addChild(self.makeRect(.blue, atPoint: CGPoint(x: xPos, y: yPos)))
                default:
                    break
                }
                xPos += 32
            }
            yPos -= 32
            xPos = -32*5
        }
    }
    func clearMap() {
        for rect in self.allRect {
            rect.isUserInteractionEnabled = false
            rect.run(SKAction.sequence([
                SKAction.group([
                    SKAction.fadeOut(withDuration: 0.5),
                    SKAction.scale(to: 2.0, duration: 0.5)
                ]),
                SKAction.removeFromParent()
            ]))
        }
        self.allRect = []
    }
    
    var maps: [[[Int]]] = [
        [
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 0, 0, 1, 1, 1, 1],
            [1, 1, 1, 1, 0, 0, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        ],
        [
            [1, 1, 1, 1, 1, 0, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 0, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 0, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 0, 1, 1, 1, 1],
            [0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
            [1, 1, 1, 1, 0, 0, 0, 0, 0, 0],
            [1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 0, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 0, 1, 1, 1, 1, 1]
        ],
        [
            [1, 0, 1, 1, 1, 0, 1, 1, 0, 1],
            [0, 1, 0, 0, 0, 1, 0, 0, 1, 0],
            [1, 0, 1, 1, 1, 0, 1, 1, 0, 1],
            [1, 0, 1, 1, 0, 0, 1, 1, 0, 1],
            [0, 1, 0, 0, 1, 1, 0, 1, 0, 1],
            [1, 0, 1, 0, 1, 1, 0, 0, 1, 0],
            [1, 0, 1, 1, 0, 0, 1, 1, 0, 1],
            [1, 0, 1, 1, 0, 1, 1, 1, 0, 1],
            [0, 1, 0, 0, 1, 0, 0, 0, 1, 0],
            [1, 0, 1, 1, 0, 1, 1, 1, 0, 1]
        ],
        [
            [4, 1, 4, 1, 4, 1, 4, 1, 4, 1],
            [1, 4, 1, 4, 1, 4, 1, 4, 1, 4],
            [1, 4, 1, 4, 1, 4, 1, 4, 1, 4],
            [1, 4, 1, 4, 1, 4, 1, 4, 1, 4],
            [4, 1, 4, 1, 4, 1, 4, 1, 4, 1],
            [1, 4, 1, 4, 1, 4, 1, 4, 1, 4],
            [4, 1, 4, 1, 4, 1, 4, 1, 4, 1],
            [4, 1, 4, 1, 4, 1, 4, 1, 4, 1],
            [4, 1, 4, 1, 4, 1, 4, 1, 4, 1],
            [1, 4, 1, 4, 1, 4, 1, 4, 1, 4]
        ],
        [
            [2, 0, 2, 0, 2, 0, 2, 0, 2, 0],
            [0, 2, 0, 2, 0, 2, 0, 2, 0, 2],
            [0, 2, 1, 2, 1, 2, 1, 2, 1, 2],
            [0, 2, 0, 2, 0, 2, 0, 2, 0, 2],
            [2, 1, 2, 1, 2, 1, 2, 1, 2, 0],
            [0, 2, 1, 2, 1, 2, 1, 2, 1, 2],
            [2, 0, 2, 0, 2, 0, 2, 0, 2, 0],
            [2, 1, 2, 1, 2, 1, 2, 1, 2, 0],
            [2, 0, 2, 0, 2, 0, 2, 0, 2, 0],
            [0, 2, 0, 2, 0, 2, 0, 2, 0, 2]
        ],
        [
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3],
            [3, 0, 3, 0, 3, 0, 3, 0, 3, 0],
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3],
            [3, 0, 3, 0, 3, 0, 3, 0, 3, 0],
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3],
            [3, 0, 3, 0, 3, 0, 3, 0, 3, 0],
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3],
            [3, 0, 3, 0, 3, 0, 3, 0, 3, 0],
            [0, 3, 0, 3, 0, 3, 0, 3, 0, 3],
            [3, 0, 3, 0, 3, 0, 3, 0, 3, 0]
        ]
    ]
    func randomMap() -> [[Int]]? {
        return self.maps.randomElement()
    }
    func button(text: String, size: CGSize) -> SUIButton {
        let b = SUIButton(size: size)
        let l = SKLabelNode(text: text)
        l.fontSize = 32
        l.verticalAlignmentMode = .center
        l.fontName = "times new roman"
        b.addChild(l)
        b.zPosition = 1000
        return b
    }
    
    //このSceneがViewにセットされた直後の処理を設計します.
    override func didMove(to view: SKView) {
        //座標系の原点の位置を指定します(今回は中心にします)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.make(self.maps.value(0))
        let button_1 = self.button(text: "Random Map", size: CGSize(width: 32*7, height: 32))
        let button_2 = self.button(text: "More Random", size: CGSize(width: 32*7, height: 32))
        let button_3 = self.button(text: "Reset", size: CGSize(width: 32*4, height: 32))
        let button_4 = self.button(text: "Clear", size: CGSize(width: 32*4, height: 32))
        self.addChild(button_1)
        self.addChild(button_2)
        self.addChild(button_3)
        self.addChild(button_4)
        button_1.touchUpHandler = {
            self.make(self.veryRandomMap())
            self.clearMap()
            self.make(self.randomMap())
        }
        button_2.touchUpHandler = {
            self.clearMap()
            self.make(self.veryRandomMap())
        }
        button_3.touchUpHandler = {
            self.clearMap()
            if let map = self.maps.value(0) {
                self.make(map)
            }
        }
        button_4.touchUpHandler = {
            self.clearMap()
        }
        button_1.position = CGPoint(x: 32*11, y: 32*2)
        button_2.position = CGPoint(x: 32*11, y: 0)
        button_3.position = CGPoint(x: 32*11, y: -32*2)
        button_4.position = CGPoint(x: 32*11, y: -32*4)
    }
}


//ViewにセットするSceneの値を作成します.
let scene = MyGameScene(size: CGSize(width: 1024, height: 640))

//Sceneのアスペクト比を設定します.
scene.scaleMode = .aspectFit

//画面に表示するViewの値を作成します.
let view = SKView(frame: CGRect(x: 0, y: 0, width: 1024, height: 640))
view.showsNodeCount = true
//ViewにSceneをセットします
view.presentScene(scene)
//SKViewを画面に表示します.
PlaygroundPage.current.setLiveView(view)
