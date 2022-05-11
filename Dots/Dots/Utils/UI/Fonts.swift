//
//  Fonts.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 21/04/21.
//  Copyright © 2021 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

extension UIFont {
    static func sketch(size: CGFloat) -> UIFont {
        guard !AccessibilitySettings.simplifyFont else { return .systemFont(ofSize: size, weight: .medium) }
        return UIFont(name: "ItsaSketch", size: size)
            ?? UIFont(descriptor: UIFontDescriptor(name: "ItsaSketch", size: size), size: size)
    }
}

final class FontLoader {
    private static var hasLoaded: Bool = false

    static func loadSketchFont() {
        guard hasLoaded == false else { return }
        let bundle = Bundle(for: FontLoader.self)

        guard let fontURL = bundle.url(forResource: "ItsaSketch", withExtension: "ttf") else { return }
        guard let data = try? Data(contentsOf: fontURL) else { return }
        guard let provider = CGDataProvider(data: data as CFData),
            let font = CGFont(provider) else { return }

        var error: Unmanaged<CFError>?

        if CTFontManagerRegisterGraphicsFont(font, &error) == false {
            guard let errorTakeUnretainedValue = error?.takeUnretainedValue() else { return }
            let errorDescription: CFString = CFErrorCopyDescription(errorTakeUnretainedValue)
            guard let nsError = error?.takeUnretainedValue() as AnyObject as? NSError else { return }
            NSException(
                name: NSExceptionName.internalInconsistencyException,
                reason: errorDescription as String,
                userInfo: [NSUnderlyingErrorKey: nsError]
            ).raise()
        }
    }
}
