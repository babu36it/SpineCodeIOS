//
//  CommentSectionView.swift
//  spine
//
//  Created by Mac on 23/06/22.
//

import SwiftUI

struct CommentSectionView: View {
    @State var commentText = ""
    let replyCount = 2
    @State var comments = [comment1, comment2]
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Title4(title: "COMMENTS")
                CustomTextFieldDynamic(searchText: $commentText, placeHolder: "Add a public comment")
                    .onSubmit {
                        print("enter tapped")
                        if commentText.count > 1 {
                            let newComment = Comment(name: "Test", comment: commentText, replies: [], liked: false)
                            comments.append(newComment)
                            commentText = ""
                        }
                    }
            }
            VStack {
                ForEach($comments, id: \.self) { $comment in
                    CommentPersonView(comment: comment)
                }
            }
        }.padding(.horizontal, 20)
        
    }
}

struct CommentPersonView: View {
    let comment: Comment
    @State var showAlert = false
    @State var textF = ""
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            CircularBorderedProfileView(image: comment.image, size: 44, borderWidth: 0, showShadow: false)
            VStack(alignment: .leading, spacing: 5) {
                SubHeader5(title: comment.name)
                Title4(title: comment.comment, fColor: .lightBlackText)
                HStack(spacing: 20) {
                    Button { } label: {
                        Image(systemName: ImageName.heartFill)
                            .foregroundColor(.lightGray1)
                    }
                    ButtonComment(title: "Reply") {
                        showAlert = true
                    }
                    
                    if getReplyCount() != "" {
                        ButtonComment(title: getReplyCount()) {
                        }
                    }
                    Spacer()
                    Title4(title: "1d", fColor: .lightGray1)
                }
                if !comment.replies.isEmpty {
                    ForEach(comment.replies, id: \.self) { sudComment in
                        CommentPersonView(comment: sudComment)
                    }
                }
            }
            
        }.padding(.vertical, 10)
        //works only on iOS 16
            .alert("Type Your message", isPresented: $showAlert, actions: {
                TextField("Username", text: $textF)
                Button("Send", action: {})
                Button("Cancel", role: .cancel, action: {})
            })
    }
    
    func getReplyCount()-> String{
        let count = comment.replies.count
        switch count {
        case 0:
            return ""
        case 1:
            return "1 reply"
        default:
            return "\(count) replies"
        }
    }
}


struct CommentSectionView_Previews: PreviewProvider {
    static var previews: some View {
        CommentSectionView()
    }
}


struct ButtonComment: View {
    let title: String
    var onTapped: ()-> Void
    var body: some View {
        Button(title){
            onTapped()
        }.foregroundColor(.lightBrown)
            .font(.Poppins(type: .regular, size: 14))
    }
}







