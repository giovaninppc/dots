//
//  CGPoint+Operations.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 22/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

func * (_ lhs: CGSize, _ rhs: CGFloat) -> CGSize {
    .init(width: lhs.width * rhs, height: lhs.height * rhs)
}
