import SpriteKit

/// Base Weapn Class
class Weapon: SKSpriteNode, SceneUpdatable {
    let stateDictInc: [GameStates: UIColor] = [
        .doodle: .red,
        .blueprint: .white,
        .watercolor: .black
    ]

    private init() {
        super.init(texture: nil, color: .white, size: CGSize(width: 20, height: 20))
    }

    init(texture: SKTexture, size: CGSize) {
        super.init(texture: texture, color: .white, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func update(for state: GameStates) {
        self.color = stateDictInc[state]!
    }

    func reachEnd() {
        self.selfDestruct()
    }

    func selfDestruct() {
        // Make animation
        self.removeFromParent()
    }
}
