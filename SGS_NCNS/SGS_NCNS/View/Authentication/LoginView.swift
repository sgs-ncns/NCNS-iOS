//
//  LoginView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/17.
//

import SwiftUI
import AlertToast

/*
 로그인 화면을 구성하는 View입니다.
 GoogleUserAuthModel을 앱 실행 시 초기화시켜 뷰와 연결시킵니다.
 */

struct LoginView: View {
    @EnvironmentObject var googleUserAuthModel: GoogleUserAuthModel
    @EnvironmentObject var loginCheckModel: LoginCheckModel
    @StateObject private var loginViewModel = LoginViewModel()
    @State var showToast = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Image("Instagram_logo_white")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 100)
                    
                    VStack(spacing: 20) {
                        LoginCustomTextField(text: $loginViewModel.email, placeholder: Text("Email"), imageName: "envelope")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                        
                        CustomSecureField(text: $loginViewModel.password, placeholder: Text("Password"))
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("Forgot Password?")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                                .padding(.trailing, 32)
                        })
                    }
                    
                    Button {
                        loginViewModel.login()
                        UIApplication.shared.endEditing()
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color("SignInButton"))
                            .clipShape(Capsule())
                            .padding()
                            .opacity(loginViewModel.canSubmit ? 1 : 0.6)
                    }
                    .disabled(!loginViewModel.canSubmit)
                    .onChange(of: loginViewModel.isLogin) { isLogin in
                        if isLogin {
                            loginCheckModel.isLoggedIn = true
                        }
                    }
                    
                    
                    VStack(spacing: 10) {
                        GoogleSignInButtonWrapper(handler: googleUserAuthModel.signIn)
                            .frame(width: 280, height: 44, alignment: .center)
                            .onReceive(googleUserAuthModel.$isLoginSuccess) {
                                if $0 {
                                    loginCheckModel.isLoggedIn = true
                                }
                            }
                        
                        AppleSignInButtonWrapper()
                            .frame(width: 280, height: 44, alignment: .center)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        loginCheckModel.isLoggedIn = true
                    }, label: {
                        Text("ContentView")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    })
                    
                    NavigationLink(
                        destination:
                            UserSignUpView(showToast: $showToast)
                            .navigationBarHidden(true),
                        label: {
                            HStack {
                                Text("Don't have an account?")
                                    .font(.system(size: 14))
                                Text("Sign Up")
                                    .font(.system(size: 14, weight: .semibold))
                            }.foregroundColor(.white)
                        }).padding(.bottom, 16)
                }
                .padding(.top, -44)
            }
            .toast(isPresenting: $showToast){
                AlertToast(displayMode: .banner(.slide), type: .regular, title: "👋 Sign Up Complete!", subTitle: "Try Login First!")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
