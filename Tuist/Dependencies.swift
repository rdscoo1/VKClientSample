import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: .init(
        [
            .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1")),
            .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .exact("5.5.0")),
            .remote(url: "https://github.com/kean/Nuke.git", requirement: .exact("10.7.1"))
        ]
        //   productTypes: [:],
        //   baseSettings: .settings()
        //        targetSettings: ["Realm": headerSearchPaths("", "")]
    ),
    platforms: [.iOS])
