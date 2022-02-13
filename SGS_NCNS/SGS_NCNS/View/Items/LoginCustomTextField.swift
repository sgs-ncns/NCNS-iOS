//
//  LoginCustomTextField.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/24.
//

import SwiftUI

/*
 일반 커스텀 텍스트필드입니다.
 */

struct LoginCustomTextField: View {
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color(.init(white: 1, alpha: 0.5)))
                    .padding(.leading, 40)
            }
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
                
                TextField("", text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
        }
    }
}

struct LoginCustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        LoginCustomTextField(text: .constant(""), placeholder: Text("Email"), imageName: "envelope")
    }
}
