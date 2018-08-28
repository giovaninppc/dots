//
//  ResourceController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 05/06/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

extension ChangeGameViewController {
    
    func updateResourceLabel() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(resourceMode(_:)))
        longPress.minimumPressDuration = 1
        longPress.cancelsTouchesInView = false
        self.view.addGestureRecognizer(longPress)
        let tap = UITapGestureRecognizer(target: self, action: #selector(startedTouchingScreen(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func startedTouchingScreen(_ touch: UITapGestureRecognizer) {
        if isShowingResources {
            isShowingResources = false
            return
        }
//        print("start")
//        self.isLoadingResources = true
//        if touch.state == .ended {
////            self.isLoadingResources = false
//            print("end")
//        }
    }
    
    func loadResources() {
        let image = UIImageView(frame:
            CGRect(x: 0, y: 0, width: 200, height: 200))
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "doodleBaloon")
        self.loadingView = image
        image.center = instaniatePosition
        self.view.addSubview(image)
    }
    
    func cancelLoadingResources() {
        if let view = self.loadingView {
            view.removeFromSuperview()
        }
    }
    
    @objc func resourceMode(_ longPress: UILongPressGestureRecognizer) {
        self.instaniatePosition = longPress.location(ofTouch: 0, in: self.view)
        if longPress.state == UIGestureRecognizerState.began {
            isShowingResources = !isShowingResources
        }
    }
    
    func hideResources() {
        loadingView?.removeFromSuperview()
        UIView.animate(withDuration: 0.3) {
            self.resourceContainerViewTopConstraint.constant = UIScreen.screens[0].bounds.maxY
            self.view.layoutIfNeeded()
        }
    }
    
    func showResources() {
        showMarkers(at: instaniatePosition)
        UIView.animate(withDuration: 0.3) {
            self.resourceContainerViewTopConstraint.constant = self.resourceContainerViewTopConstraintValue
            self.view.layoutIfNeeded()
        }
    }
    
    func showMarkers(at position: CGPoint) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 5
        view.center = position
        self.view.addSubview(view)
        self.loadingView = view
    }
    
}
