//
//  SocialMediaApp.swift
//  WorkOnStatePropertyWrapper
//
//  Created by  Prince Shrivastav on 30/08/24.
//

import SwiftUI

/*
 Project: Social Media App

 Goal: Create a social media app that allows users to:

 - Post updates with text, images, and videos
 - Follow other users
 - See a feed of posts from followed users
 - Like and comment on posts
 - View user profiles
 */

class User: ObservableObject {
    @Published var id: String
    @Published var name: String
    @Published var profilePicture: URL?
    init(id: String, name: String, profilePicture: URL? = nil) {
        self.id = id
        self.name = name
        self.profilePicture = profilePicture
    }
}

class Post: ObservableObject {
    @Published var id: String
    @Published var text: String
    @Published var media: [URL]?
    @Published var likes: [User]?
    @Published var comments: [Comment]?
    init(id: String, text: String, media: [URL]? = nil, likes: [User]? = nil, comments: [Comment]? = nil) {
        self.id = id
        self.text = text
        self.media = media
        self.likes = likes
        self.comments = comments
    }
}

class Comment: ObservableObject {
    @Published var id: String
    @Published var text: String
    @Published var user: User
    init(id: String, text: String, user: User) {
        self.id = id
        self.text = text
        self.user = user
    }
}


struct FeedView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var post: Post
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

struct PostCell: View {
    let post: Post
    var body: some View {
        VStack {
            Text(post.text)
            MediaView(urls: post.media)
            HStack {
                Button(action: {
                    // Like/unlike post
                }) {
                    Text("Like")
                }
                Button(action: {
                    // Comment on post
                }) {
                    Text("Comment")
                }
            }
        }
    }
}



struct MediaView: View {
    let urls: [URL]?
    var body: some View {
        if let urls, !urls.isEmpty {
            ForEach(urls, id: \.self) { url in
                AsyncImage(url: url)
                    .scaledToFit()
                    .frame(width: 100)
                    .clipShape(Circle())
            }
        } else {
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
        }
    }
}

#Preview {
    PostCell(post: Post(id: "", text: ""))
}
