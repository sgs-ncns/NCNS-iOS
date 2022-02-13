//
//  UserSignUpViewModel.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/02/09.
//

import Foundation
import Combine
import SwiftUI

/*
 회원가입을 위한 ViewModel
 회원가입에는 Email, Nickname, AccountName, Password가 필수
 Email, AccountName - 중복이 불가능하므로 Focus Out하면 서버를 통해 중복 체크
 비밀번호는 8자리 이상, 최소 1개의 문자와 특문 필요
 */
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
    let emailFormatCheck = NSPredicate(format: "SELF MATCHES %@", Const.LoginFormCheck.EMAIL_FORMAT_CHECK)
    
    // 비밀번호 8글자, 적어도 1개의 문자, 1개의 특수문자
    let passwordFormatCheck = NSPredicate(format: "SELF MATCHES %@", Const.LoginFormCheck.PASSWORD_FORMAT_CHECK)
    
    init() {
        self.userSignUpModel = UserSignUpModel()
        
        $email
            .map { email in
                return self.emailFormatCheck.evaluate(with: email)
            }
            .assign(to: \.isEmailFormat, on: self)
            .store(in: &bag)

        $nickname
            .map { nickname in
                return !nickname.isEmpty
            }
            .sink { [weak self] values in
                self?.isNicknameEmpty = values
            }
            .store(in: &bag)

        $accountName
            .map { accountName in
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

        // Email
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
    func requestSignUp(data: UserSignUpModel) {
        APIRequest.shared.requestSignUp(data: data)
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
    
    // 텍스트 필드에 입력한 값들을 모델의 데이터구조와 데이터바인딩을 하는 함수
    func data() {
        self.userSignUpModel.email = email
        self.userSignUpModel.nickname = nickname
        self.userSignUpModel.accountName = accountName
        self.userSignUpModel.password = password
    }
}
