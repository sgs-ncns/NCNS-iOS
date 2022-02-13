//
//  KeychainQuery.swift
//  KeychainPractice
//
//  Created by 한상혁 on 2022/01/31.
//


import Security
import Alamofire
import Foundation

/*
 유저의 정보, AccessToken, refreshToken을 관리하기 위해 Keychain을 사용했습니다.
 */

func create(_ service: String, account: String, value: String) {
    
    // 1. Query 작성
    let keyChainQuery: NSDictionary = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account,
        kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
    ]
    // allowLossyConversion은 인코딩 과정에서 손실되는 것을 허용할 것인지 설정
    
    // 2. Delete
    // Key Chain은 Key값의 중복이 생기면 저장할 수 없기 때문에 먼저 Delete
    SecItemDelete(keyChainQuery)
    
    // 3. Create
    let status: OSStatus = SecItemAdd(keyChainQuery, nil)
    assert(status == noErr, "failed to saving Token")
}

func read(_ service: String, account: String) -> String? {
    let keyChainQuery: NSDictionary = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account,
        kSecReturnData: kCFBooleanTrue, // CFData 타입으로 불러오라는 의미
        kSecMatchLimit: kSecMatchLimitOne // 중복이 되는 경우 하나의 값만 가져오기
    ]
    // CFData 타입 -> AnyObject로 받고, Data로 타입변환
    
    // Read
    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
    
    // Read 성공 및 실패한 경우
    if(status == errSecSuccess) {
        let retrivedData = dataTypeRef as! Data
        let value = String(data: retrivedData, encoding: String.Encoding.utf8)
        return value
    } else {
        print("failed to loading, status code = \(status)")
        return nil
    }
}

func delete(_ service: String, account: String) {
    let keyChainQuery: NSDictionary = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ]
    
    let status = SecItemDelete(keyChainQuery)
    assert(status == noErr, "fail to delete the value, status code = \(status)")
}
