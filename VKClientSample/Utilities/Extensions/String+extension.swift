//
//  Date+extension.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 21.05.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import Foundation

extension String {
    static func postDate(timestamp: Double) -> String? {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
