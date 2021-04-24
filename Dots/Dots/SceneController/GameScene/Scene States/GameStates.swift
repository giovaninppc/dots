//
//  GameStates.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 24/04/21.
//  Copyright © 2021 Giovani Nascimento Pereira. All rights reserved.
//

enum GameStates {
    case doodle
    case blueprint
    case watercolor

    func buildState() -> GameSceneState {
        switch self {
        case .doodle:
            return DoodleState()
        case .blueprint:
            return BlueprintState()
        case .watercolor:
            return WatercolorState()
        }
    }
}
