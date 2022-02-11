//
//  RegistrationView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/17.
//

import SwiftUI
import AlertToast

struct UserSignUpView: View {
    @StateObject var userSignUpViewModel: UserSignUpViewModel
    @FocusState private var isFocused1: Bool
    @FocusState private var isFocused2: Bool
    @Binding var showToast: Bool
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                
                VStack(spacing: 20) {
                    
                    CustomTextField(text: $userSignUpViewModel.email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( userSignUpViewModel.email == "" || isFocused1 || (!isFocused1 && userSignUpViewModel.isEmailFormat) ? .clear : Color.red)
                                .foregroundColor(.clear)
                                .padding(.horizontal, 32)
                        )
                        .focused($isFocused1)
                        .onChange(of: isFocused1) { newValue in
                            if !newValue {
                                print("\(userSignUpViewModel.isEmailFormat)")
                                // 중복체크 서버 통신 추가
                            }
                        }
                    
                    CustomTextField(text: $userSignUpViewModel.nickname, placeholder: Text("Nickname"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                    
                    CustomTextField(text: $userSignUpViewModel.accountName, placeholder: Text("Account Name"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .focused($isFocused2)
                        .onChange(of: isFocused2) { newValue in
                            if !newValue {
                                print("Account Name Lost focus")
                                // account 중북 서버 통신
                            }
                        }
                    
                    CustomSecureField(text: $userSignUpViewModel.password, placeholder: Text("Password"))
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                }
                .padding(.top, 154)
                
                Button(action: {
                    userSignUpViewModel.data()
                    userSignUpViewModel.requestLogin(data: userSignUpViewModel.userSignUpModel)
                    
                }, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color("SignInButton"))
                        .clipShape(Capsule())
                        .padding()
                })
                    .onChange(of: userSignUpViewModel.goBack) { goBack in
                        if goBack {
                            showToast.toggle()
                            mode.wrappedValue.dismiss()
                        }
                    }
                    .opacity(userSignUpViewModel.canSubmit ? 1 : 0.6)
                    .disabled(!userSignUpViewModel.canSubmit)
                Spacer()
                
                Button(action: {
                    
                    mode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                    }.foregroundColor(.white)
                        .padding(.bottom, 16)
                })
            }
        }
    }
}

//struct UserSignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserSignUpView()
//    }
//}
