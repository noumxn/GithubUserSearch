//
//  ContentView.swift
//  GithubUserSearch
//
//  Created by Nouman Syed on 11/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var user: GithubUser?
    @State private var projects: [GithubProject] = []
    @State private var followers: [GithubUser] = []
    @State private var following: [GithubUser] = []
    let username: String

    init(username: String) {
        self.username = username
    }
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                
                AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .foregroundColor(.secondary)
                }
                .frame(width: 120, height: 120)
                
                Text(user?.login ?? "Username")
                    .bold()
                    .font(.title3)
                
                if let _ = user?.bio {
                    Text(user?.bio ?? "Bio...")
                        .padding()
                }
                
                if let twitterUsername = user?.twitterUsername,
                   let twitterURL = URL(string: "https://twitter.com/\(twitterUsername)") {
                    HStack {
                        Text("Twitter:")
                        Link(destination: twitterURL) {
                            Text(twitterUsername)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Projects")
                        .font(.title)
                    
                    ForEach(projects, id: \.name) { project in
                        VStack(alignment: .leading) {
                            Text(project.name)
                                .font(.headline)
                                .bold()
                            if let description = project.description {
                                Text(description)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Followers")
                        .font(.title)
                    
                    ForEach(followers, id: \.login) { followers in
                        HStack() {
                            AsyncImage(url: URL(string: followers.avatarUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: 50, height: 50)
                            Text(followers.login)
                                .font(.headline)
                                .bold()
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Following")
                        .font(.title)
                    
                    ForEach(following, id: \.login) { following in
                        HStack() {
                            AsyncImage(url: URL(string: following.avatarUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: 50, height: 50)
                            Text(following.login)
                                .font(.headline)
                                .bold()
                        }
                    }
                }
                

                
                Spacer()
            }
            .padding()
            .onAppear() {
                fetchData()
            }
        
        }
    }
    func fetchData() {
            Task {
                do {
                    user = try await getUserData(username: username)
                    projects = try await getProjects(username: username)
                    followers = try await getFollowers(username: username)
                    following = try await getFollowing(username: username)
                } catch GHError.invalidURL {
                    print("Invalid URL")
                } catch GHError.invalidResponse {
                    print("Invalid Response")
                } catch GHError.invalidData {
                    print("Invalid Data")
                } catch {
                    print("Uh oh! Something went wrong :/")
                }
            }
        }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(username: "noumxn")
//    }
//}
