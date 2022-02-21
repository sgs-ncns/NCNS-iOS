//
//  UploadPostView.swift
//  InstagramSwiftUITutorial
//
//  Created by 한상혁 on 2021/12/28.
//

import SwiftUI

struct UploadPostView: View {
    @StateObject var uploadPostViewModel: UploadPostViewModel
    @StateObject var imagePageViewModel: ImagePageViewModel
    @State private var selectedImage: UIImage?
    @State var postImage: Image?
    @State var captionText = ""
    @State var imagePickerPresented = false
    @State var hashtag: [String] = []
    @State var usertag: [String] = []
    @State var uploadDate: String = ""
    @State var loadingIndicator = false
    
    var body: some View {
        let accountName = KeyChainUtils().read("login", account: "accountName")!
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
                    ZStack {
                        if self.loadingIndicator {
                            ProgressView()
                                .zIndex(1)
                        }
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
                                self.uploadDate = nowDate()
                                imagePageViewModel.uploadImage(selectedImage ?? UIImage(named: "user_default")!, dateNow: uploadDate)
                                self.uploadPostViewModel.requestCreatePost(data: UploadPostModel(accountName: accountName, content: captionText, hashtag: hashtag, imagePath: self.uploadDate))
                                parserTag(captionText: captionText)
                            }, label: {
                                Text("Share")
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(width: 360, height: 50)
                                    .background(Color.blue)
                                    .cornerRadius(5)
                                    .foregroundColor(.white)
                            }).padding()
                        }.zIndex(0)
                    }
                    .onReceive(self.imagePageViewModel.$isUploadLoading, perform: {
                        if $0 {
                            self.loadingIndicator = true
                        } else {
//                            self.uploadPostViewModel.requestCreatePost(data: UploadPostModel(accountName: accountName, content: captionText, hashtag: hashtag, imagePath: self.uploadDate))
                            self.loadingIndicator = false
                        }
                    })
                    .onChange(of: self.loadingIndicator, perform: {
                        if !$0 {
                            postImage = nil
                            imagePickerPresented = false
                            captionText = ""
                            hashtag = []
                            usertag = []
                        }
                    })
                }
                Spacer()
            }.navigationTitle("Upload")
                .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

extension UploadPostView {
    func parserTag(captionText: String) {
        let splitText = captionText.split(separator: " ")
            .map {"\($0)"}
        
        splitText.forEach { i in
            if i.hasPrefix("#") {
                let dropPrefix = i.deletingPrefix("#")
                self.hashtag.append(dropPrefix)
            } else if i.hasPrefix("@") {
                let dropPrefix = i.deletingPrefix("@")
                self.usertag.append(dropPrefix)
            }
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}
