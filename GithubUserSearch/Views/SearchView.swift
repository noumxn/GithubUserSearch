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

    var body: some View {
        VStack {
            TextField("Enter GitHub Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Search") {
                if !username.isEmpty {
                    isSearching = true
                }
            }
            .padding()
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

