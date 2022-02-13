//
//  LoginViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/24.
//

import Foundation
import Combine

/*
 로그인을 하기 위한 ViewModel
 아이디에형식에 따라 다른 서버 API로 통신하도록 설계
 형식을 체크하고, Email 형식이면 EmailLogin API, 아니면 IDLogin API로 통신한다.
 비밀번호는 8글자이상, 적어도 1개의 문자와 특문이 들어가야함.
*/
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isEmailFormat = false
    @Published var isPasswordFormat = false
    @Published var canSubmit = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    // 이메일 형식 체크
    let emailFormatCheck = NSPredicate(format: "SELF MATCHES %@", Const.LoginFormCheck.EMAIL_FORMAT_CHECK)
    
    // 비밀번호 8글자, 적어도 1개의 문자, 1개의 특수문자
    let passwordFormatCheck = NSPredicate(format: "SELF MATCHES %@", Const.LoginFormCheck.PASSWORD_FORMAT_CHECK)
    
    init() {
        // 형식 체크
        $email
            .map { email in
                return self.emailFormatCheck.evaluate(with: email)
            }
            .assign(to: \.isEmailFormat, on: self)
            .store(in: &cancellableSet)
        
        $password
            .map { password in
                return self.passwordFormatCheck.evaluate(with: password)
            }
            .assign(to: \.isPasswordFormat, on: self)
            .store(in: &cancellableSet)
        
        // 형식 체크에 따라서 버튼 활성화
        Publishers.CombineLatest($isEmailFormat, $isPasswordFormat)
            .map { isEmailFormat, isPasswordFormat in
                return (!(self.email.isEmpty) && isPasswordFormat)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellableSet)
    }
    
    
    
    func login() {
        // 이메일로 로그인 시도
        if isEmailFormat {
            print("Login in \(email), \(password) ")
            email = ""
            password = ""
        } else {
            // accountName으로 시도
            print("Login in not email \(email)")
            email = ""
            password = ""
        }
        
    }
}

//extension LoginViewModel {
//    func requestLogin() {
//
//    }
//}
