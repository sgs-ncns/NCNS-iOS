//
//  UserSignUpViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/09.
//

import Foundation
import Combine
import SwiftUI

class UserSignUpViewModel: ObservableObject {
    @Published var userSignUpModel: UserSignUpModel
    @Published var email = ""
    @Published var nickname = ""
    @Published var accountName = ""
    @Published var password = ""
    @Published var isEmailFormat = false
    @Published var isNicknameEmpty = true
    @Published var isAccountNameEmpty = true
    @Published var isPasswordFormat = false
    @Published var goBack: Bool = false
    @Published var canSubmit = false
    @Environment(\.presentationMode) var mode
    
    private var bag = Set<AnyCancellable>()
    
    // 이메일 형식 체크
    let emailFormatCheck = NSPredicate(format: "SELF MATCHES %@", "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
    
    // 비밀번호 8글자, 적어도 1개의 문자, 1개의 특수문자
    let passwordFormatCheck = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")
    
    init() {
        userSignUpModel = UserSignUpModel()
        userSignUpModel.accountName = email
        
        $email
            .map { email in
                return self.emailFormatCheck.evaluate(with: email)
            }
            .assign(to: \.isEmailFormat, on: self)
            .store(in: &bag)

        $nickname
            .map { nickname in
                print("nickname is Empty?: \(nickname.isEmpty)")
                return !nickname.isEmpty
            }
            .sink { [weak self] values in
                self?.isNicknameEmpty = values
            }
            .store(in: &bag)

        $accountName
            .map { accountName in
                print("accountName is Empty?: \(accountName.isEmpty)")
                return !accountName.isEmpty
            }
            .sink { [weak self] values in
                self?.isAccountNameEmpty = values
            }
            .store(in: &bag)
        
        $password
            .map { password in
                return self.passwordFormatCheck.evaluate(with: password)
            }
            .assign(to: \.isPasswordFormat, on: self)
            .store(in: &bag)

        Publishers.CombineLatest4($isEmailFormat, $isNicknameEmpty, $isAccountNameEmpty, $isPasswordFormat)
            .map { isEmailFormat, isNicknameEmpty, isAccountNameEmpty, isPasswordFormat in
                return (isEmailFormat && isNicknameEmpty && isAccountNameEmpty && isPasswordFormat)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &bag)
    }
}

extension UserSignUpViewModel {
    //회원가입
    func requestLogin(data: UserSignUpModel) {
        APIRequest.shared.requestLogin(data: data)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<[String:String]>.self) {
                    print(response)
                    if response.responseCode == "1000" {
                        print("회원가입 성공")
                        self?.goBack.toggle()
                    } else {
                        print("Response Code Error")
                    }
                } else {
                    print("Response Catch Error")
                }
            })
            .store(in: &bag)
    }
    
    func data() {
        self.userSignUpModel.email = email
        self.userSignUpModel.nickname = nickname
        self.userSignUpModel.accountName = accountName
        self.userSignUpModel.password = password
    }
}
