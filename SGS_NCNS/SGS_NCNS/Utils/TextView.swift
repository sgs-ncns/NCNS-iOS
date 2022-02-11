//
//  TextView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/16.
//
import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var hashTag: [String]
    @Binding var humanTag: [String]

    func makeCoordinator() -> Coordinator {
        Coordinator(self, hashTag: hashTag, humanTag: humanTag)
    }

    func makeUIView(context: Context) -> UITextView {

        let myTextView = UITextView()
        myTextView.delegate = context.coordinator

        myTextView.font = UIFont(name: "HelveticaNeue", size: 15)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)

        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator : NSObject, UITextViewDelegate {

        private var splitText: [String] = []
        var parent: TextView
        var hashTag: [String]
        var humanTag: [String]
        

        init(_ uiTextView: TextView, hashTag: [String], humanTag: [String]) {
            self.parent = uiTextView
            self.hashTag = hashTag
            self.humanTag = humanTag
        }                             
        
        func TagChecker(_ sliceText: String) {
            self.splitText = sliceText.split(separator: " ").map{ "\($0)"}
            
            splitText.enumerated().forEach {
                if $1.hasPrefix("#") {
                    hashTag.append($1)
                } else if $1.hasPrefix("@") {
                    humanTag.append($1)
                }
            }
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
            TagChecker(textView.text)
        }
    }
}
