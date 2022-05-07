//
//  GameStates.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 24/04/21.
//  Copyright © 2021 Giovani Nascimento Pereira. All rights reserved.
//

enum GameStates: Int, CaseIterable {
    case blueprint = 0
    case doodle = 1
    case watercolor = 2

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

    static var currentStatus: Int = 0
    static var current: GameStates = .doodle

    static func update(_ swipe: Swipe) {
        var next = current.rawValue + swipe.rawValue
        if next == allCases.count {
            next = 0
        } else if next < 0 {
            next = allCases.count - 1
        }
        current = allCases[next]
    }
}
