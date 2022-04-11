import ProjectDescription

let project = Project(
    name: "VKClientSample",
    organizationName: "com.rkhdeveloper.VKClientSample",
    packages: [
        .remote(url: "https://github.com/realm/realm-swift.git", requirement: .exact("10.25.0"))
    ],
    settings: nil,
    targets: [
        Target(name: "VKClientSample",
               platform: .iOS,
               product: .app,
               bundleId: "com.rkhdeveloper.VKClientSample",
               deploymentTarget: .iOS(targetVersion: "12.0", devices: .iphone),
               infoPlist: .file(path: "VKClientSample/Supporting Files/Resources/Info.plist"),
               sources: [
                "VKClientSample/Components/**",
                "VKClientSample/Services/**",
                "VKClientSample/Models/**",
                "VKClientSample/Modules/**",
                "VKClientSample/Core/**",
                "VKClientSample/Supporting Files/AppDelegate.swift",
                "VKClientSample/Supporting Files/Constants/**",
                "VKClientSample/Supporting Files/Extensions/**"
               ],
               resources: [
                "VKClientSample/Supporting Files/Resources/Assets.xcassets",
                "VKClientSample/Supporting Files/Resources/*.lproj/**"
               ],
               copyFiles: nil,
               entitlements: nil,
               scripts: [
//                .post(
//                    script: """
//                    export PATH="$PATH:/opt/homebrew/bin"
//                    swiftlint autocorrect
//                    if which swiftlint >/dev/null; then
//                    swiftlint
//                    else
//                    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
//                    fi
//                    """, name: "SwiftLint")
               ],
               dependencies: [
                .external(name: "SnapKit"),
                .external(name: "Alamofire"),
                .external(name: "Nuke"),
                .package(product: "RealmSwift")
               ],
               settings: nil,
               coreDataModels: [],
               environment: [:],
               launchArguments: [],
               additionalFiles: []
              )
    ],
    schemes: [],
    fileHeaderTemplate: nil,
    additionalFiles: [],
    resourceSynthesizers: [.strings(), .assets()]
)
