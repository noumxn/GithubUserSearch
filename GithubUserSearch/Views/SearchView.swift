//
//  SearchView.swift
//  GithubUserSearch
//
//  Created by Nouman Syed on 11/6/23.
//

import SwiftUI

struct SearchView: View {
    @State private var username: String = ""
    @State private var isSearching = false
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Search") {
                self.username = self.username.trimmingCharacters(in: .whitespaces)
                if !self.username.isEmpty {
                    isSearching = true
                    errorMessage = nil
                } else {
                    errorMessage = "Username cannot be empty."
                }
            }
            .padding()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .sheet(isPresented: $isSearching) {
            ContentView(username: username)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

