//
//  GithubAPI.swift
//  GithubUserSearch
//
//  Created by Nouman Syed on 11/5/23.
//

import Foundation

func getUserData(username: String) async throws -> GithubUser {
    print("-\(username)-")
    let endpoint = "https://api.github.com/users/\(username)"
    
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
        return try decoder.decode(GithubUser.self, from: data)
    } catch {
        throw GHError.invalidData
    }
}
