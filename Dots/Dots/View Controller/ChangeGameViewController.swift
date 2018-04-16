//
//  ChangeGameViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 16/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import SpriteKit

enum GameStates {
    case doodle
    case blueprint
}

class ChangeGameViewController: UIViewController {

    // Outlets
    @IBOutlet weak var gameScene: SKView!
    
    // Variables
    var gameStates: [GameStates] = [.doodle, .blueprint]
    var currentStatus: Int = 0
    
    var scene: ChangeGameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initiate the GameScene
        if let scene = gameScene?.scene as? ChangeGameScene {
            scene.configureGame()
            self.scene = scene
        } else {
            fatalError("Game Scene not initialized")
        }
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(makeTransition(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(makeTransition(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }

    @objc func makeTransition(_ swipe: UISwipeGestureRecognizer) {
        
        if swipe.direction == .left {
            print("LEFT")
            currentStatus += 1
            if currentStatus == gameStates.count {
                currentStatus = 0
            }
            transitionLeft()
        } else if swipe.direction == .right {
            print("RIGHT")
            currentStatus -= 1
            if currentStatus < 0 {
                currentStatus = gameStates.count - 1
            }
            transitionRight()
        }
    }
    
    func transitionLeft() {
        // Show animation
        updateSceneState()
        self.scene.updateGame(for: gameStates[currentStatus])
    }
    
    func transitionRight() {
        // Show animation
        updateSceneState()
        self.scene.updateGame(for: gameStates[currentStatus])
    }
    
    func updateSceneState() {
        switch gameStates[currentStatus] {
        case .doodle:
            self.scene.state = SketchState()
        case .blueprint:
            self.scene.state = BlueprintState()
        }
    }
}
