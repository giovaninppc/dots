//
//  GearAnimation.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 10/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

extension UIView {
    func addGearAnimation() {
        UIView.animate(withDuration: 0.3, delay: 1.0, options: [.allowUserInteraction]) {
            self.transform = self.transform.rotated(by: .pi / 8)
        } completion: { _ in
            self.delay()
        }
    }

    private func delay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.addGearAnimation()
        }
    }
}
