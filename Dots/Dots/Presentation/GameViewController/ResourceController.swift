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
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resourceMode)))
    }
    
    @objc func resourceMode() {
        isShowingResources = !isShowingResources
    }
    
    func hideResources() {
        UIView.animate(withDuration: 0.5) {
            self.resourceContainerViewTopConstraint.constant = UIScreen.screens[0].bounds.maxY
            self.view.layoutIfNeeded()
        }
    }
    
    func showResources() {
        UIView.animate(withDuration: 0.5) {
            self.resourceContainerViewTopConstraint.constant = self.resourceContainerViewTopConstraintValue
            self.view.layoutIfNeeded()
        }
    }
    
}
