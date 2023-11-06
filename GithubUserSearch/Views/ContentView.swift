//
//  ContentView.swift
//  GithubUserSearch
//
//  Created by Nouman Syed on 11/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var user: GithubUser?
    let username: String

    init(username: String) {
        self.username = username
    }
    
    var body: some View {
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

            
            Spacer()
        }
        .padding()
        .onAppear() {
            fetchData()
        }
    }
    func fetchData() {
            Task {
                do {
                    user = try await getUserData(username: username)
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
//        ContentView(username: <#String#>)
//    }
//}