//
//  GameViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 15/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var gameScene: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initiate the GameScene
        if let scene = gameScene?.scene as? GameScene {
            switch self.title! {
            case "Blueprint":
                scene.state = BlueprintState()
            case "Doodle":
                scene.state = SketchState()
            default:
                print("Error on getting game state")
            }
            scene.configureGame()
        }
    }
}
