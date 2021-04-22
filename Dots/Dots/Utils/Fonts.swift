//
//  Fonts.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 21/04/21.
//  Copyright © 2021 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

extension UIFont {
    static func sketch(size: CGFloat) -> UIFont {
        return UIFont(name: "ItsaSketch", size: size) ?? .systemFont(ofSize: size)
    }
}
