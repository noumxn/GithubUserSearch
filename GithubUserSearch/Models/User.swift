//
//  User.swift
//  GithubUserSearch
//
//  Created by Nouman Syed on 11/5/23.
//

import Foundation

struct GithubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String?
    let twitterUsername: String?
}
