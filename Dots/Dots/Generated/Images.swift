// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public static let aimBlack = ImageAsset(name: "aim-black")
  public static let aimWhite = ImageAsset(name: "aim-white")
  public static let blueprint = ImageAsset(name: "Blueprint")
  public static let paper = ImageAsset(name: "Paper")
  public static let watercolor = ImageAsset(name: "Watercolor")
  public static let tutorialBackground = ImageAsset(name: "tutorialBackground")
  public static let blueprintBaloon0 = ImageAsset(name: "blueprintBaloon-0")
  public static let blueprintBaloon1 = ImageAsset(name: "blueprintBaloon-1")
  public static let blueprintBaloon2 = ImageAsset(name: "blueprintBaloon-2")
  public static let blueprintBaloon3 = ImageAsset(name: "blueprintBaloon-3")
  public static let blueprintBaloon = ImageAsset(name: "blueprintBaloon")
  public static let doodleBaloon0 = ImageAsset(name: "doodleBaloon-0")
  public static let doodleBaloon1 = ImageAsset(name: "doodleBaloon-1")
  public static let doodleBaloon2 = ImageAsset(name: "doodleBaloon-2")
  public static let doodleBaloon3 = ImageAsset(name: "doodleBaloon-3")
  public static let doodleBaloon4 = ImageAsset(name: "doodleBaloon-4")
  public static let doodleBaloon = ImageAsset(name: "doodleBaloon")
  public static let watercolorBaloon0 = ImageAsset(name: "watercolorBaloon0")
  public static let watercolorBaloon1 = ImageAsset(name: "watercolorBaloon1")
  public static let blueprintBaloonBomb = ImageAsset(name: "blueprintBaloonBomb")
  public static let doodleBaloonBomb = ImageAsset(name: "doodleBaloonBomb")
  public static let watercolorBaloonBomb = ImageAsset(name: "watercolorBaloonBomb")
  public static let blueprintBottom = ImageAsset(name: "blueprintBottom")
  public static let tutorialBlue = ColorAsset(name: "TutorialBlue")
  public static let pinPaper = ImageAsset(name: "pinPaper")
  public static let rippedLateralPaper = ImageAsset(name: "rippedLateralPaper")
  public static let stackedPaper = ImageAsset(name: "stackedPaper")
  public static let fastForward = ImageAsset(name: "fastForward")
  public static let pause = ImageAsset(name: "pause")
  public static let doodlePlane = ImageAsset(name: "doodlePlane")
  public static let paperPlane = ImageAsset(name: "paperPlane")
  public static let watercolorPlane = ImageAsset(name: "watercolorPlane")
  public static let resourceA = ImageAsset(name: "ResourceA")
  public static let resourceB = ImageAsset(name: "ResourceB")
  public static let resourceC = ImageAsset(name: "ResourceC")
  public static let corner = ImageAsset(name: "corner")
  public static let onboardingArrow = ImageAsset(name: "onboarding-arrow")
  public static let spikeBallBlueprint = ImageAsset(name: "spikeBallBlueprint")
  public static let spikeBallDoodle = ImageAsset(name: "spikeBallDoodle")
  public static let spikeBallWatercolor1 = ImageAsset(name: "spikeBallWatercolor_1")
  public static let spikeBallWatercolor2 = ImageAsset(name: "spikeBallWatercolor_2")
  public static let spikeBallWatercolor3 = ImageAsset(name: "spikeBallWatercolor_3")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = Color(asset: self)

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image named \(name).")
    }
    return result
  }
}

public extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
