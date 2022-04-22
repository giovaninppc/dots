//
//  Idle.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 22/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

protocol Idle { func idle() }

protocol Describable {
    var displayName: String { get }
    var displayDescription: String { get }
}
