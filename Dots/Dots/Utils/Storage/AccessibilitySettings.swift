//
//  AccessibilitySettings.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 23/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

enum AccessibilitySettings {
    enum Keys: String, StorageKey {
        case vibrations
    }

    @Stored(key: Keys.vibrations, default: true)
    static var vibrationsEnabled: Bool
}
