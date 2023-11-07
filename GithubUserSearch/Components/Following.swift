//
//  Following.swift
//  GithubUserSearch
//
//  Created by Nouman Syed on 11/6/23.
//

import Foundation

func getFollowing(username:String) async throws -> [GithubUser] {
    let endpoint = "https://api.github.com/users/\(username)/following"
    
    guard let url = URL(string: endpoint) else {
        throw GHError.invalidURL
    }
    
    let (data, res) = try await URLSession.shared.data(from: url)
    
    guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let followingList = try decoder.decode([GithubUser].self, from: data)
        return followingList
    } catch {
        throw GHError.invalidData
    }
}
