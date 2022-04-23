import Foundation
import UIKit

public final class HapticWorker {
    public enum HapticType {
        // Notification
        case success
        case error
        case warning

        // Impact
        case lightImpact
        case mediumImpact
        case heavyImpact

        // Selection
        case selection

        var generator: UIFeedbackGenerator {
            switch self {
            case .success, .error, .warning:
                return UINotificationFeedbackGenerator()
            case .lightImpact:
                return UIImpactFeedbackGenerator(style: .light)
            case .mediumImpact:
                return UIImpactFeedbackGenerator(style: .medium)
            case .heavyImpact:
                return UIImpactFeedbackGenerator(style: .heavy)
            case .selection:
                return UISelectionFeedbackGenerator()
            }
        }

        var notificationType: UINotificationFeedbackGenerator.FeedbackType {
            switch self {
            case .success:
                return .success
            case .error:
                return .error
            case .warning:
                return .warning
            default:
                return .error
            }
        }
    }

    private var multipleUse: Bool
    private var type: HapticType
    private var feedbackGenerator: Any?

    public init(type: HapticWorker.HapticType, multipleUse: Bool = false) {
        self.type = type
        self.multipleUse = multipleUse

        let feedback = type.generator
        feedback.prepare()
        feedbackGenerator = feedback
    }

    public func fire() {
        fireIfPossible()
    }

    private func fireIfPossible() {
        guard let feedback = feedbackGenerator as? UIFeedbackGenerator else { return }
        switch type {
        case .success, .error, .warning:
            guard let generator = feedback as? UINotificationFeedbackGenerator else { return }
            generator.notificationOccurred(type.notificationType)

        case .lightImpact, .mediumImpact, .heavyImpact:
            guard let generator = feedback as? UIImpactFeedbackGenerator else { return }
            generator.impactOccurred()

        case .selection:
            guard let generator = feedback as? UISelectionFeedbackGenerator else { return }
            generator.selectionChanged()
        }

        if multipleUse { feedback.prepare() }
    }
}
