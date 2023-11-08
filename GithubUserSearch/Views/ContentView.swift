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
    @State private var selectedTab = 0
    @State private var errorMessage: String? = nil
    
    let username: String

    init(username: String) {
        self.username = username
    }
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
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
                
                Picker(selection: $selectedTab, label: Text("Select a tab")) {
                    Text("Projects").tag(0)
                    Text("Followers").tag(1)
                    Text("Following").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                if selectedTab == 0 {
                    // Display Projects
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
                } else if selectedTab == 1 {
                    // Display Followers
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Followers")
                            .font(.title)
                        
                        ForEach(followers, id: \.login) { follower in
                            HStack() {
                                AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .foregroundColor(.secondary)
                                }
                                .frame(width: 50, height: 50)
                                Text(follower.login)
                                    .font(.headline)
                                    .bold()
                            }
                        }
                    }
                } else if selectedTab == 2 {
                    // Display Following
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Following")
                            .font(.title)
                        
                        ForEach(following, id: \.login) { followed in
                            HStack() {
                                AsyncImage(url: URL(string: followed.avatarUrl)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .foregroundColor(.secondary)
                                }
                                .frame(width: 50, height: 50)
                                Text(followed.login)
                                    .font(.headline)
                                    .bold()
                            }
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
                    errorMessage = "Invalid URL"
                } catch GHError.invalidData {
                    errorMessage = "User not found or invalid data received."
                } catch GHError.invalidResponse {
                    errorMessage = "User not found or invalid data received."
                } catch {
                    errorMessage = "Uh oh! Something went wrong :/"
                }
            }
        }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(username: "noumxn")
//    }
//}
