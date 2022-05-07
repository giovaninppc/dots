import SpriteKit

// Handle user interaction

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)

        if let enemy = touchedNodes.first as? Enemy {
            controllerDelegate?.show(enemy: enemy)
        } else if let weapon = touchedNodes.first as? Weapon {
            controllerDelegate?.show(weapon: weapon)
        }
    }
}

extension GameScene {
    func addWeapon(_ weapon: Weapon, at position: CGPoint) {
        weapon.position = position
        self.scene?.addChild(weapon)
    }
}
