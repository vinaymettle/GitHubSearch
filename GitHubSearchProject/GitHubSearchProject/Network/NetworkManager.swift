//
//  NetworkManager.swift
//  GitHubSearchProject
//
//  Created by Vinay Ponna on 3/31/20.
//  Copyright © 2020 Vinay Ponna. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private let domainURLString = "https://api.github.com/users"
    
    func fetchUsers(completionHandler: @escaping ([GitHubUser]) -> Void) {
        
        var request = URLRequest(url: URL(string: domainURLString)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            if let error = error {
                print("Error fetching users: \(error)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
                let gitUser = try? JSONDecoder().decode([GitHubUser].self, from: data) {
                completionHandler(gitUser)
            }
        })
        task.resume()
    }
    
    func fetchUserdetails(userName:String, completionHandler: @escaping (MyGitHub) -> Void) {
        
        var request = URLRequest(url: URL(string: domainURLString + "/\(userName)")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            if let error = error {
                print("Error fetching users: \(error)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            guard let data = data,
                let gitUserInfo = try? JSONDecoder().decode(MyGitHub.self, from: data) else {
                    return
            }
            completionHandler(gitUserInfo)
        })
        task.resume()
    }
    
    func fetchRepos(userName:String, completionHandler: @escaping ([GitRepos]) -> Void) {
        
        var request = URLRequest(url: URL(string: domainURLString + "/\(userName)/repos")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            if let error = error {
                print("Error fetching users: \(error)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
                let gitRepo = try? JSONDecoder().decode([GitRepos].self, from: data) {                completionHandler(gitRepo)
            }
        })
        task.resume()
    }
    
}
