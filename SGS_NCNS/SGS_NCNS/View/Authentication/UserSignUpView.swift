//
//  RegistrationView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/17.
//

import SwiftUI
import AlertToast

/*
 회원가입 화면을 보여주는 뷰입니다.
 FocusState를 통해 FocusOut이 되면 해당 텍스트필드(Email, AccountName)가 형식에 맞는지, 중복인지(서버와 통신하여) 확인합니다.
 
 */

struct UserSignUpView: View {
    @StateObject var userSignUpViewModel = UserSignUpViewModel()
    @FocusState private var isEmailFieldFocused: Bool
    @FocusState private var isAccountFieldFocused: Bool
    @FocusState private var isPasswordFieldFocused: Bool
    @Binding var showToast: Bool
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                
                VStack(spacing: 0) {
                    
                    CustomTextField(text: $userSignUpViewModel.email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( userSignUpViewModel.email == "" || isEmailFieldFocused || (!isEmailFieldFocused && (userSignUpViewModel.isEmailFormat && !userSignUpViewModel.isEmailDuplicate)) ? .clear : Color.red)
                                .foregroundColor(.clear)
                                .padding(.horizontal, 32)
                        )
                        .focused($isEmailFieldFocused)
                        .onChange(of: isEmailFieldFocused) { newValue in
                            if !newValue {
                                // 중복체크 서버 통신 추가
                                // request 함수 내에서 isDuplication 해서 조건에 걸어놓기
                                if userSignUpViewModel.isEmailFormat {
                                    userSignUpViewModel.requestEmailDuplicate(email: userSignUpViewModel.email)
                                }
                            } else {
                                userSignUpViewModel.isEmailDuplicate = false
                            }
                        }
                        .padding(.bottom, userSignUpViewModel.email == "" || isEmailFieldFocused || (!isEmailFieldFocused && (userSignUpViewModel.isEmailFormat && !userSignUpViewModel.isEmailDuplicate)) ? 20 : 0)
                    
                    if !(userSignUpViewModel.email == "" || isEmailFieldFocused || (!isEmailFieldFocused && (userSignUpViewModel.isEmailFormat && !userSignUpViewModel.isEmailDuplicate))) {
                        if !userSignUpViewModel.isEmailFormat {
                            Text("Email format is not correct.")
                                .font(.system(size: 13))
                                .foregroundColor(.red)
                                .padding([.top, .bottom], 2)
                        } else {
                            Text("Email is Duplicated.")
                                .font(.system(size: 13))
                                .foregroundColor(.red)
                                .padding([.top, .bottom], 2)
                        }
                    }
                    
                    CustomTextField(text: $userSignUpViewModel.nickname, placeholder: Text("Nickname"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 20)
                    
                    CustomTextField(text: $userSignUpViewModel.accountName, placeholder: Text("Account Name"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( userSignUpViewModel.accountName == "" || isAccountFieldFocused || (!isAccountFieldFocused && !userSignUpViewModel.isAccountDuplicate) ? .clear : Color.red)
                                .foregroundColor(.clear)
                                .padding(.horizontal, 32)
                        )
                        .focused($isAccountFieldFocused)
                        .onChange(of: isAccountFieldFocused) { newValue in
                            if !newValue && userSignUpViewModel.accountName != "" {
                                // account 중북 서버 통신
                                userSignUpViewModel.requestAccountDuplicate(account: userSignUpViewModel.accountName)
                            } else {
                                userSignUpViewModel.isAccountDuplicate = false
                            }
                        }
                        .padding(.bottom, userSignUpViewModel.accountName == "" || isAccountFieldFocused || (!isAccountFieldFocused && !userSignUpViewModel.isAccountDuplicate) ? 20 : 0)
                    
                    if !(userSignUpViewModel.accountName == "" || isAccountFieldFocused || (!isAccountFieldFocused && !userSignUpViewModel.isAccountDuplicate)) {
                            Text("Account is Duplicated.")
                                .font(.system(size: 13))
                                .foregroundColor(.red)
                                .padding([.top, .bottom], 2)
                    }
                    
                    CustomSecureField(text: $userSignUpViewModel.password, placeholder: Text("Password"))
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( userSignUpViewModel.password == "" || isPasswordFieldFocused || (!isPasswordFieldFocused && userSignUpViewModel.isPasswordFormat) ? .clear : Color.red)
                                .foregroundColor(.clear)
                                .padding(.horizontal, 32)
                        )
                        .focused($isPasswordFieldFocused)
                        .onChange(of: isPasswordFieldFocused) { newValue in
                            if !newValue {
                            }
                        }
                        .padding(.bottom, userSignUpViewModel.password == "" || isPasswordFieldFocused || (!isPasswordFieldFocused && userSignUpViewModel.isPasswordFormat) ? 20 : 0)
                    
                    if !(userSignUpViewModel.password == "" || isPasswordFieldFocused || (!isPasswordFieldFocused && userSignUpViewModel.isPasswordFormat)) {
                            Text("The password must be at least one word and one digit.")
                                .font(.system(size: 13))
                                .foregroundColor(.red)
                                .padding([.top, .bottom], 2)
                    }
                }
                .padding(.top, 154)
                
                Button(action: {
                    userSignUpViewModel.data()
                    userSignUpViewModel.requestSignUp(data: userSignUpViewModel.userSignUpModel)
                    
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
                    .opacity(userSignUpViewModel.canSubmit && userSignUpViewModel.canSubmitMore ? 1 : 0.6)
                    .disabled(!(userSignUpViewModel.canSubmit && userSignUpViewModel.canSubmitMore))
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
