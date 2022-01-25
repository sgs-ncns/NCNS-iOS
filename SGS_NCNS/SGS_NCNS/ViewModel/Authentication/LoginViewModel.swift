//
//  LoginViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isEmailFormat = false
    @Published var isPasswordFormat = false
    @Published var canSubmit = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    // 이메일 형식 체크
    let emailFormatCheck = NSPredicate(format: "SELF MATCHES %@", "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
    
    // 비밀번호 8글자, 적어도 1개의 문자, 1개의 특수문자
    let passwordFormatCheck = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")
    
    init() {
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
        
        Publishers.CombineLatest($isEmailFormat, $isPasswordFormat)
            .map { isEmailFormat, isPasswordFormat in
                return (!(self.email.isEmpty) && isPasswordFormat)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellableSet)
    }
    
    
    
    func login() {
        if isEmailFormat {
            print("Login in \(email), \(password) ")
            email = ""
            password = ""
        } else {
            print("Login in not email \(email)")
            email = ""
            password = ""
        }
        
    }
}
