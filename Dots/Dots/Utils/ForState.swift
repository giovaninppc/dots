//
//  ForState.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 07/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

func forState<T>(doodle: T, watercolor: T, blueprint: T) -> T {
    switch GameStates.current {
    case .blueprint:
        return blueprint
    case .doodle:
        return doodle
    case .watercolor:
        return watercolor
    }
}
