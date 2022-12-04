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

struct EventDetailCommentSectionView: View {
    @StateObject var commentsVM: EventDetailCommentSectionViewModel
    
    @State private var commentText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Title4(title: "COMMENTS")
                CustomTextFieldDynamic(searchText: $commentText, placeHolder: "Add a public comment")
                    .onSubmit {
                        print("enter tapped")
                        if !commentText.isEmpty {
                            if let userID: String = AppUtility.shared.userInfo?.data?.usersId {
                                commentsVM.postComment(commentText, eventID: commentsVM.event.id, userID: userID) { status, error in
                                    if status {
                                        commentText = ""
                                    } else if let error = error {
                                        print(error)
                                    }
                                }
                            }
                        }
                    }
                    .submitLabel(.send)
            }
            VStack {
                ForEach(commentsVM.comments) { comment in
                    EventDetailCommentPersonView(comment: comment)
                        .environmentObject(commentsVM)
                }
            }
        }
        .onAppear {
            commentsVM.getComments(for: commentsVM.event.id)
        }
        .padding(.horizontal, 20)
    }
}

struct EventDetailCommentPersonView: View {
    @EnvironmentObject var commentsVM: EventDetailCommentSectionViewModel
    
    let comment: EventComment
    
    @State private var showAlert = false
    @State private var textF = ""
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if let imagePath = comment.getUserImage(for: commentsVM.serverUserImagePath) {
                RemoteImage(imageDownloader: DefaultImageDownloader(imagePath: imagePath))
                    .circularClip(radius: 44)
            } else {
                Color.white
                    .circularClip(radius: 44)
            }
            VStack(alignment: .leading, spacing: 5) {
                if let userName = comment.postUserName {
                    SubHeader5(title: userName)
                }
                if let commentStr = comment.comment {
                    Title4(title: commentStr, fColor: .lightBlackText)
                }
                HStack(spacing: 20) {
                    Button { } label: {
                        Image(systemName: ImageName.heartFill)
                            .foregroundColor(.lightGray1)
                    }
                    ButtonComment(title: "Reply") {
                        showAlert = true
                    }
                    
                    if !replyCountLabel.isEmpty {
                        ButtonComment(title: replyCountLabel) {
                        }
                    }
                    Spacer()
                    Title4(title: "1d", fColor: .lightGray1)
                }
                if let commentReplies = commentReplies, !commentReplies.isEmpty {
                    ForEach(commentReplies) { commentReply in
                        EventDetailCommentPersonView(comment: commentReply)
                    }
                }
            }
        }
        .onAppear {
            commentsVM.getCommentReplies(for: comment.id)
        }
        .padding(.vertical, 10)
        .alert("Type Your message", isPresented: $showAlert, actions: {
            TextField("Username", text: $textF)
            Button("Send", action: {})
            Button("Cancel", role: .cancel, action: {})
        })
    }
    
    var commentReplies: [EventComment]? {
        guard let commentID: String = comment.id else { return nil }
        return commentsVM.commentReplies[commentID]?.data
    }
    
    var replyCountLabel: String {
        let count = commentReplies?.count ?? 0
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
