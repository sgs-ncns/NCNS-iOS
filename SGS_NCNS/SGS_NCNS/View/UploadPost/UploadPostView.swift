//
//  UploadPostView.swift
//  InstagramSwiftUITutorial
//
//  Created by 한상혁 on 2021/12/28.
//

import SwiftUI

struct UploadPostView: View {
    @State private var selectedImage: UIImage?
    @State var postImage: Image?
    @State var captionText = ""
    @State var imagePickerPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                if postImage == nil {
                    Button(action: { imagePickerPresented.toggle() }, label: {
                        Image("plus_photo")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .clipped()
                            .padding(.top, 56)
                            .foregroundColor(.black)
                    }).sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                        ImagePicker(image: $selectedImage)
                    })
                } else if let image = postImage {
                    HStack(alignment: .top) {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 96, height: 96)
                            .clipped()
                        
    //                    TextField("Enter tour caption ...", text: $captionText)
                        TextView(text: $captionText)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                        
                    }.padding()
                    
                    Button(action: {
                        postImage = nil
                        imagePickerPresented = false
                        captionText = ""
                    }, label: {
                        Text("Share")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 360, height: 50)
                            .background(Color.blue)
                            .cornerRadius(5)
                            .foregroundColor(.white)
                    }).padding()
                }
                
                
                
                Spacer()
            }.navigationTitle("Upload")
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

extension UploadPostView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView()
    }
}
