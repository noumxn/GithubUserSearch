//
//  GithubUserSearchApp.swift
//  GithubUserSearch
//
//  Created by Nouman Syed on 11/5/23.
//

import SwiftUI

@main
struct GithubUserSearchApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SearchView()
                    .navigationTitle("GitHub User Search")
                    .font(.title2)
            }
        }
    }
}
