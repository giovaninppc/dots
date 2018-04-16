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
    case watercolor
}

class ChangeGameViewController: UIViewController {

    // Outlets
    @IBOutlet weak var gameScene: SKView!
    
    // Variables
    var gameStates: [GameStates] = [.doodle, .blueprint]
    var currentStatus: Int = 0
    
    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initiate the GameScene
        if let scene = gameScene?.scene as? GameScene {
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
        updateSceneState()
        self.scene.updateGame(for: gameStates[currentStatus])
        UIView.transition(with: self.view, duration: 0.5, options: .transitionCurlUp, animations: nil, completion: nil)
    }
    
    func transitionRight() {
        // Show animation
        updateSceneState()
        self.scene.updateGame(for: gameStates[currentStatus])
        UIView.transition(with: self.view, duration: 0.5, options: .transitionCurlDown, animations: nil, completion: nil)
    }
    
    func updateSceneState() {
        switch gameStates[currentStatus] {
        case .doodle:
            self.scene.state = DoodleState()
        case .blueprint:
            self.scene.state = BlueprintState()
        case .watercolor:
            print("CREATE WATERCOLOR STATE")
        }
    }
    
    open func takeScreenshot() -> UIImage? {
        
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
}
