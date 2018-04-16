//
//  MenuViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 13/04/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//
// Reference: https://spin.atomicobject.com/2015/12/23/swift-uipageviewcontroller-tutorial/
//

import UIKit

class MenuPageViewController: UIPageViewController {
    
    var enemyController: EnemyController = EnemyController()
    
    // Reference array to the Menu view controllers
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newMenuViewController("BlueprintScene"),
                self.newMenuViewController("SketchScene")]
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initializing the datasource
        self.dataSource = self
        self.delegate = self
        
        // Intializing the first view
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Instantiate a new viewController for the game
    private func newMenuViewController(_ levelName: String) -> UIViewController {
        // Load from storyboard
        let viewController = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(levelName)")
        
        return viewController
    }
    
}

// MARK: UIPageViewControllerDataSource

extension MenuPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}

extension MenuPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {
        
        print("TRANSITIONING")
        print(pageViewController)
        print(pendingViewControllers)
        
//        guard let view = pendingViewControllers[0] as? GameViewController else { return }
//        guard let skView = view.gameScene else { return }
//        enemyController.currentScene = skView.scene as? GameScene
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        
        if completed {
            guard let view = pageViewController.viewControllers![0] as? GameViewController else { return }
            guard let skView = view.gameScene else { return }
            enemyController.currentScene = skView.scene as? GameScene
        }
    }
    
}
