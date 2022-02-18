//
//  PrintDateTime.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/17.
//

import Foundation

// 2022-02-17 21:55:03
func nowDate() -> String {
    let now = Date()
    let date = DateFormatter()
    date.dateFormat = "yyyy-MM-dd HH:mm:ss"

    date.locale = Locale(identifier: "ko_kr")
    date.timeZone = TimeZone(abbreviation: "KST")

    let kr = date.string(from: now)
    return kr
}
