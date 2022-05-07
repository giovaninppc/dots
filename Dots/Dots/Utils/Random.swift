//
//  randon.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 07/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

func random<T>(_ objects: T...) -> T {
    return objects.randomElement() ?? objects.first!
}
