//
//  UploadPostView.swift
//  InstagramSwiftUITutorial
//
//  Created by 한상혁 on 2021/12/28.
//

import SwiftUI

struct UploadPostView: View {
    @StateObject var uploadPostViewModel: UploadPostViewModel
    @State private var selectedImage: UIImage?
    @State var postImage: Image?
    @State var captionText = ""
    @State var imagePickerPresented = false
    @State var hashtag: [String] = []
    @State var humantag: [String] = []
    
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
                    VStack {
                        HStack(alignment: .top) {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 96, height: 96)
                                .clipped()
                            
                                ZStack {
                                    TextEditor(text: $captionText)
                                    Text(captionText).opacity(0).padding(.all, 8)
                                }
                                .shadow(radius: 1)
                                .frame(height: 96)
                        }.padding()
                        
                        Spacer()
                        
                        Button(action: {
                            postImage = nil
                            imagePickerPresented = false
                            captionText = ""
                            var _ = print("\(hashtag), \(humantag)")
                        }, label: {
                            Text("Share")
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width: 360, height: 50)
                                .background(Color.blue)
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }).padding()
                    }
                    
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
        UploadPostView(uploadPostViewModel: UploadPostViewModel())
    }
}
