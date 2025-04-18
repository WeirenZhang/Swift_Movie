//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle
  var string: string { .init(bundle: bundle, preferredLanguages: nil, locale: nil) }
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var info: info { .init(bundle: bundle) }
  var file: file { .init(bundle: bundle) }
  var nib: nib { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func string(bundle: Foundation.Bundle) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: nil)
  }
  func string(locale: Foundation.Locale) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: locale)
  }
  func string(preferredLanguages: [String], locale: Locale? = nil) -> string {
    .init(bundle: bundle, preferredLanguages: preferredLanguages, locale: locale)
  }
  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func info(bundle: Foundation.Bundle) -> info {
    .init(bundle: bundle)
  }
  func file(bundle: Foundation.Bundle) -> file {
    .init(bundle: bundle)
  }
  func nib(bundle: Foundation.Bundle) -> nib {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.nib.validate()
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    let bundle: Foundation.Bundle
    let preferredLanguages: [String]?
    let locale: Locale?
    var localizable: localizable { .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale)) }

    func localizable(preferredLanguages: [String]) -> localizable {
      .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale))
    }


    /// This `_R.string.localizable` struct is generated, and contains static references to 1 localization keys.
    struct localizable {
      let source: RswiftResources.StringResource.Source

      /// en translation: No information
      ///
      /// Key: Result.Empty.Placeholder
      ///
      /// Locales: en, zh-Hant
      var resultEmptyPlaceholder: RswiftResources.StringResource { .init(key: "Result.Empty.Placeholder", tableName: "Localizable", source: source, developmentValue: "No information", comment: nil) }
    }
  }

  /// This `_R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 18 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `clock`.
    var clock: RswiftResources.ImageResource { .init(name: "clock", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `clock.fill`.
    var clockFill: RswiftResources.ImageResource { .init(name: "clock.fill", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `doc.text`.
    var docText: RswiftResources.ImageResource { .init(name: "doc.text", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `doc.text.fill`.
    var docTextFill: RswiftResources.ImageResource { .init(name: "doc.text.fill", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `enl_1`.
    var enl_1: RswiftResources.ImageResource { .init(name: "enl_1", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `enl_2`.
    var enl_2: RswiftResources.ImageResource { .init(name: "enl_2", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `enl_3`.
    var enl_3: RswiftResources.ImageResource { .init(name: "enl_3", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `enl_4`.
    var enl_4: RswiftResources.ImageResource { .init(name: "enl_4", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `enl_5`.
    var enl_5: RswiftResources.ImageResource { .init(name: "enl_5", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `enl_6`.
    var enl_6: RswiftResources.ImageResource { .init(name: "enl_6", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_error`.
    var ic_error: RswiftResources.ImageResource { .init(name: "ic_error", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `ic_nodata`.
    var ic_nodata: RswiftResources.ImageResource { .init(name: "ic_nodata", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `movieclapper`.
    var movieclapper: RswiftResources.ImageResource { .init(name: "movieclapper", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `movieclapper.fill`.
    var movieclapperFill: RswiftResources.ImageResource { .init(name: "movieclapper.fill", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `popcorn`.
    var popcorn: RswiftResources.ImageResource { .init(name: "popcorn", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `popcorn.fill`.
    var popcornFill: RswiftResources.ImageResource { .init(name: "popcorn.fill", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `video`.
    var video: RswiftResources.ImageResource { .init(name: "video", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `video.fill`.
    var videoFill: RswiftResources.ImageResource { .init(name: "video.fill", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    let bundle: Foundation.Bundle
    var uiApplicationSceneManifest: uiApplicationSceneManifest { .init(bundle: bundle) }

    func uiApplicationSceneManifest(bundle: Foundation.Bundle) -> uiApplicationSceneManifest {
      .init(bundle: bundle)
    }

    struct uiApplicationSceneManifest {
      let bundle: Foundation.Bundle

      let uiApplicationSupportsMultipleScenes: Bool = false

      var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest"], key: "_key") ?? "UIApplicationSceneManifest" }
      var uiSceneConfigurations: uiSceneConfigurations { .init(bundle: bundle) }

      func uiSceneConfigurations(bundle: Foundation.Bundle) -> uiSceneConfigurations {
        .init(bundle: bundle)
      }

      struct uiSceneConfigurations {
        let bundle: Foundation.Bundle
        var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations"], key: "_key") ?? "UISceneConfigurations" }
        var uiWindowSceneSessionRoleApplication: uiWindowSceneSessionRoleApplication { .init(bundle: bundle) }

        func uiWindowSceneSessionRoleApplication(bundle: Foundation.Bundle) -> uiWindowSceneSessionRoleApplication {
          .init(bundle: bundle)
        }

        struct uiWindowSceneSessionRoleApplication {
          let bundle: Foundation.Bundle
          var defaultConfiguration: defaultConfiguration { .init(bundle: bundle) }

          func defaultConfiguration(bundle: Foundation.Bundle) -> defaultConfiguration {
            .init(bundle: bundle)
          }

          struct defaultConfiguration {
            let bundle: Foundation.Bundle
            var uiSceneConfigurationName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneConfigurationName") ?? "Default Configuration" }
            var uiSceneDelegateClassName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate" }
            var uiSceneStoryboardFile: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneStoryboardFile") ?? "Main" }
          }
        }
      }
    }
  }

  /// This `_R.file` struct is generated, and contains static references to 2 resource files.
  struct file {
    let bundle: Foundation.Bundle

    /// Resource file `MovieFavoriteMainVCSettings.json`.
    var movieFavoriteMainVCSettingsJson: RswiftResources.FileResource { .init(name: "MovieFavoriteMainVCSettings", pathExtension: "json", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `MovieInfoMainVCSettings.json`.
    var movieInfoMainVCSettingsJson: RswiftResources.FileResource { .init(name: "MovieInfoMainVCSettings", pathExtension: "json", bundle: bundle, locale: LocaleReference.none) }
  }

  /// This `_R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    let bundle: Foundation.Bundle

    /// Nib `ABWebViewController`.
    var abWebViewController: RswiftResources.NibReference<UIKit.UIView> { .init(name: "ABWebViewController", bundle: bundle) }

    func validate() throws {

    }
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var main: main { .init(bundle: bundle) }

    func main(bundle: Foundation.Bundle) -> main {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.main.validate()
    }


    /// Storyboard `Main`.
    struct main: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UINavigationController

      let bundle: Foundation.Bundle

      let name = "Main"
      func validate() throws {

      }
    }
  }
}