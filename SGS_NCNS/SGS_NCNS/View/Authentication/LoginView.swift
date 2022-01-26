//
//  LoginView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/17.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var googleUserAuthModel: GoogleUserAuthModel
    @StateObject private var viewModel = LoginViewModel()
    @Binding var isLogin: Bool
    
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
                    
                    // email
                    VStack(spacing: 20) {
                        LoginCustomTextField(text: $viewModel.email, placeholder: Text("Email"), imageName: "envelope")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                    // password
                        
                        CustomSecureField(text: $viewModel.password, placeholder: Text("Password"))
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                    }
                    // forgotpassword
                    
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
                    
                    // sign in
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Sign In")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 50)
                    .background(Color("SignInButton"))
                    .clipShape(Capsule())
                    .padding()
                    .opacity(viewModel.canSubmit ? 1 : 0.6)
                    .disabled(!viewModel.canSubmit)
                    
                    VStack(spacing: 10) {
                        GoogleSignInButtonWrapper(handler: googleUserAuthModel.signIn)
                            .frame(width: 280, height: 44, alignment: .center)
                        
                        AppleSignInButtonWrapper()
                            .frame(width: 280, height: 44, alignment: .center)
                        
                    }
                    
                      
                    Spacer()
                    
                    Button(action: {
                        isLogin = true
                    }, label: {
                        Text("ContentView")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    })
                    
                    NavigationLink(
                        destination:
                            RegistrationView()
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
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLogin: .constant(false))
    }
}
