//
//  UploadPostModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/11.
//

import Foundation

struct UploadPostModel: Codable {
    var images: String    // 사진 폴더 이름
    var content: String     // 피드 내용
    var hashtags: [String]   // 해시 태그
    var humantags: [String]  // 사람 태그
    
    private enum CodingKeys: String, CodingKey {
        case images
        case content
        case hashtags
        case humantags
    }
}
