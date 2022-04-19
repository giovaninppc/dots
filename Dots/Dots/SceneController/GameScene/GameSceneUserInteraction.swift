import SpriteKit

// Handle user interaction

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)

        lastTouch = location

        if let weapon = touchedNodes.first(where: { $0 is Weapon }) as? Weapon {
            print(weapon)
        } else {
//            print(location)
        }
    }
}

// Adding stuff

extension GameScene {
    func addWeapon(_ weapon: Weapon, at position: CGPoint) {
        weapon.position = position
        self.scene?.addChild(weapon)
        weapons.append(weapon)
    }
}
