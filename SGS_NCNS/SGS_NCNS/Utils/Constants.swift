//
//  Constants.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/11.
//

import Foundation

/*
 - Constants는 상수들을 관리하기 위한 구조체입니다.
 - 작성 방법
    1. let을 통한 상수는 영문 대문자 스네이크 표기법을 사용하여 선언합니다.
        ex) let KEY_PROFILE_IMAGE_URL = "profileIamgeUrl"
    
    2. struct로 대주제 -> 소주제로 해서 관리합니다.
        ex)
        struct Const {
            struct DatabaseKey {
                static let KEY_PROFILE_IMAGE_URL = "profileIamgeUrl"
            }
            ...
        }
        
        Usage: let data = Const.DatabaseKey.KEY_PROFILE_IMAGE_URL
 */

struct Const {
    struct LoginFormCheck {
        static let EMAIL_FORMAT_CHECK: String = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        static let PASSWORD_FORMAT_CHECK: String = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$"
    }
    
    struct GoogleOAuth {
        static let CLIENT_ID: String = "326919065220-hqsl606jviquog8dtrvcepnjror7hpc4.apps.googleusercontent.com"
    }
}
