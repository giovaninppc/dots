//
//  Achievement.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 10/05/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import GameKit

protocol Achievement {
    var key: String { get }
    var percent: Double { get }
    var showsCompletionBanner: Bool { get }

    func achievement() -> GKAchievement
}

extension Achievement {
    var showsCompletionBanner: Bool { true }

    func achievement() -> GKAchievement {
        let achieve = GKAchievement(identifier: key)
        achieve.percentComplete = percent
        achieve.showsCompletionBanner = showsCompletionBanner
        return achieve
    }
}
