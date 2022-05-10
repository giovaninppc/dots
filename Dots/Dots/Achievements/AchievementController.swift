//
//  AchievementController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 10/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import GameKit
import UIKit

final class AchievementController {
    static let shared: AchievementController = AchievementController()

    var authenticated: Bool { GKLocalPlayer.local.isAuthenticated }
    private var achievements: [GKAchievement] = []

    private init() {}

    func authenticatePlayer(from baseView: UIViewController) {
        GKLocalPlayer.local.authenticateHandler = { viewController, _ in
            if let viewToDisplay = viewController {
                baseView.present(viewToDisplay, animated: true, completion: nil)
            }
        }
    }

    func reportAllAchievements() {}

    func report(_ achievement: Achievement) {
        report([achievement])
    }

    func report(_ achievements: [Achievement]) {
        let reportPackage = achievements.map(build)
        GKAchievement.report(reportPackage) { _ in }
    }
}

extension AchievementController {
    private func loadAchievements() {
        GKAchievement.loadAchievements { result, _ in
            if let achieve = result { self.achievements = achieve }
        }
    }

    private func build(_ achievement: Achievement) -> GKAchievement {
        return achievements.first { $0.identifier == achievement.key }
            ?? achievement.achievement()
    }
}
