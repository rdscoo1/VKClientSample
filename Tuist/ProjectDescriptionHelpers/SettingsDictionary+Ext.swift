//
//  SettingsDictionary+Ext.swift
//  Dependencies
//
//  Created by Roman Khodukin on 4/11/22.
//

import ProjectDescription

public extension SettingsDictionary {
    static var frameworkSigning: Self {
        SettingsDictionary()
            .codeSignIdentityAppleDevelopment()
    }

    func prefixHeader(_ path: String) -> Self {
        merging(["GCC_PREFIX_HEADER": SettingValue(stringLiteral: path)])
    }

    func headerSearchPaths(_ paths: String...) -> Self {
        let key = "HEADER_SEARCH_PATHS"
        let complete = ["$(inherited)"] + paths
        return merging([key: .array(complete)])
    }

    func librarySearchPath(_ path: String) -> Self {
        return merging(["LIBRARY_SEARCH_PATHS": SettingValue(arrayLiteral: "$(inherited)", "$(PROJECT_DIR)/\(path)")])
    }

    func bridgingHeaderPath(_ path: String) -> Self {
        return merging(["SWIFT_OBJC_BRIDGING_HEADER": SettingValue(stringLiteral: path)])
    }
}
