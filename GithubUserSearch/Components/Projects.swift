//
//  Projects.swift
//  GithubUserSearch
//
//  Created by Nouman Syed on 11/6/23.
//

import Foundation

func getProjects(username: String) async throws -> [GithubProject] {
    let endpoint = "https://api.github.com/\(username)/repos"
    
    guard let url = URL(string: endpoint) else {
        throw GHError.invalidURL
    }
    
    let (data, res) = try await URLSession.shared.data(from: url)
    
    guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        let projectsList = try decoder.decode([GithubProject].self, from: data)
        return projectsList
    } catch {
        throw GHError.invalidData
    }
}
