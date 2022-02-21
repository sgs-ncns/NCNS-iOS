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
    @Published var loginModel: LoginModel
    @Published var email = "contea95"
    @Published var password = "12341234"
    @Published var isEmailFormat = false
    @Published var isPasswordFormat = false
    @Published var isLogin = false
    @Published var canSubmit = false
    
    private var bag: Set<AnyCancellable> = []
    
    // 이메일 형식 체크
    let emailFormatCheck = NSPredicate(format: "SELF MATCHES %@", Const.LoginFormCheck.EMAIL_FORMAT_CHECK)
    
    // 비밀번호 8글자, 적어도 1개의 문자, 1개의 특수문자
    let passwordFormatCheck = NSPredicate(format: "SELF MATCHES %@", Const.LoginFormCheck.PASSWORD_FORMAT_CHECK)
    
    init() {
        self.loginModel = LoginModel()
        // 형식 체크
        $email
            .map { email in
                return self.emailFormatCheck.evaluate(with: email)
            }
            .assign(to: \.isEmailFormat, on: self)
            .store(in: &bag)
        
        $password
            .map { password in
                return self.passwordFormatCheck.evaluate(with: password)
            }
            .assign(to: \.isPasswordFormat, on: self)
            .store(in: &bag)
        
        // 형식 체크에 따라서 버튼 활성화
        Publishers.CombineLatest($isEmailFormat, $isPasswordFormat)
            .map { isEmailFormat, isPasswordFormat in
                return (!(self.email.isEmpty) && isPasswordFormat)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &bag)
    }
    
    
    
    func login() {
        // 이메일로 로그인 시도
        if isEmailFormat {
            self.accountData()
            requestLocalLogin(data: loginModel)
            email = ""
            password = ""
            loginModel.email = nil
            loginModel.password = nil
        } else {
            // accountName으로 시도
            self.accountData()
            requestAccountLogin(data: loginModel)
            email = ""
            password = ""
            loginModel.accountName = nil
            loginModel.password = nil
        }
        
    }
}

extension LoginViewModel {
    func requestAccountLogin(data: LoginModel) {
        APIRequest.shared.requestAccountLogin(data: data)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<LoginResponseModel>.self) {
                    if response.responseCode == "0000" {
                        print("AccountLogin 성공")
                        // 토큰, userId, accountName Keychain에 저장
                        
                        let kc = KeyChainUtils()
                        kc.create("login", account: "accessToken", value: (response.data?.accessToken)!)
                        kc.create("login", account: "refreshToken", value: (response.data?.refreshToken)!)
                        kc.create("login", account: "userId", value: String((response.data?.userId ?? 0)))
                        kc.create("login", account: "accountName", value: (response.data?.accountName)!)
                        print("accessToken: \(kc.read("login", account: "accessToken")!)")
                        self?.isLogin.toggle()
                    } else {
                        print("Response Code Error")
                        print(response.message)
                    }
                } else {
                    print("Response Catch Error")
                }
            })
            .store(in: &bag)
    }
    
    func requestLocalLogin(data: LoginModel) {
        APIRequest.shared.requestLocalLogin(data: data)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                if let response = try?
                    $0.map(ResponseModel<LoginResponseModel>.self) {
//                    print(response.responseCode)
                    if response.responseCode == "0000" {
                        print("LocalLogin 성공")
                        // 토큰, userId, accountName Keychain에 저장
                        let kc = KeyChainUtils()
                        kc.create("login", account: "accessToken", value: (response.data?.accessToken)!)
                        kc.create("login", account: "refreshToken", value: (response.data?.refreshToken)!)
                        kc.create("login", account: "userId", value: String((response.data?.userId) ?? 0))
                        kc.create("login", account: "accountName", value: (response.data?.accountName)!)
                        self?.isLogin.toggle()
                    } else {
                        print("Response Code Error")
                    }
                }else {
                    print("Response local Catch Error")
                }
            })
            .store(in: &bag)
    }
    
    func accountData() {
        if self.isEmailFormat {
            self.loginModel.email = email
        }else {
            self.loginModel.accountName = email
        }
        self.loginModel.password = password
        
    }
}
