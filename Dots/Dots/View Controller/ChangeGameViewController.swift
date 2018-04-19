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
    @IBOutlet weak var coverImageView: UIImageView!
    
    // Variables
    var gameStates: [GameStates] = [.blueprint, .doodle, .watercolor]
    var currentStatus: Int = 0
    
    var scene: GameScene!
    var enemyController: EnemyController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initiate the GameScene
        if let scene = gameScene?.scene as? GameScene {
            scene.configureGame()
            self.scene = scene
        } else {
            fatalError("Game Scene not initialized")
        }
        updateSceneState()
        
        // DEBUG
        gameScene.showsFPS = true
        gameScene.showsNodeCount = true
        gameScene.showsPhysics = true
        
        //Initiate enemyController
        enemyController = EnemyController()
        enemyController.scene = scene
        
        // Add gesture to change game environment
        addSwipeGestures()
    }

    @objc func makeTransition(_ swipe: UISwipeGestureRecognizer) {
        
        if swipe.direction == .left {
            currentStatus += 1
            if currentStatus == gameStates.count {
                currentStatus = 0
            }
            transitionLeft()
        } else if swipe.direction == .right {
            currentStatus -= 1
            if currentStatus < 0 {
                currentStatus = gameStates.count - 1
            }
            transitionRight()
        }
    }
    
    func transitionLeft() {
//        coverImageView.image = takeScreenshot()
//        self.view.bringSubview(toFront: coverImageView)
        updateSceneState()
        self.scene.updateGame(for: gameStates[currentStatus])
//        UIView.transition(with: coverImageView, duration: 0.5, options: .transitionCurlUp,
//                          animations: {
//                            self.coverImageView.image = nil
//        }, completion: { (_) -> Void in
//            self.view.sendSubview(toBack: self.coverImageView)
//        })
    }
    
    func transitionRight() {
        // Show animation
//        coverImageView.image = #imageLiteral(resourceName: "test")
        updateSceneState()
        self.scene.updateGame(for: gameStates[currentStatus])
//        self.view.bringSubview(toFront: coverImageView)
//        UIView.transition(with: coverImageView, duration: 0.5, options: .transitionCurlDown,
//                          animations: {
//                            self.coverImageView.image = nil
//        }, completion: { (_) -> Void in
//            self.view.sendSubview(toBack: self.coverImageView)
//        })
    }
    
    func updateSceneState() {
        switch gameStates[currentStatus] {
        case .doodle:
            self.scene.state = DoodleState()
        case .blueprint:
            self.scene.state = BlueprintState()
        case .watercolor:
            self.scene.state = WatercolorState()
        }
    }
    
    func addSwipeGestures() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(makeTransition(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(makeTransition(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func takeScreenshot() -> UIImage? {
        
        var screenshotImage: UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in: context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
}
