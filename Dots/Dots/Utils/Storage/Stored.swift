//
//  Stored.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 23/04/22.
//  Copyright © 2022 Giovani Nascimento Pereira. All rights reserved.
//

import Foundation

protocol StorageKey {
    var key: String { get }
}

extension StorageKey where Self: RawRepresentable, RawValue == String {
    var key: String { rawValue }
}

@propertyWrapper
struct Stored<Value, Key: StorageKey> {
    let key: Key
    let `default`: Value

    private let container: UserDefaults = .standard

    var wrappedValue: Value {
        get { container.value(for: key) as? Value ?? self.default }
        set { container.setValue(newValue, for: key) }
    }
}

extension UserDefaults {
    func value(for key: StorageKey) -> Any? {
        value(forKey: key.key)
    }

    func setValue(_ value: Any?, for key: StorageKey) {
        setValue(value, forKey: key.key)
    }
}
