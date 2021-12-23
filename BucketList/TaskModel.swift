//
//  TaskModel.swift
//  BucketList
//
//  Created by admin on 23/12/2021.
//

import Foundation
class TaskModel {
    // Note that we are passing in a function (similar to our use of callbacks in JS). This function will allow the ViewController that calls this method to dictate what runs upon completion
    
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Specify the API that we will be sending the Request to
        let url = URL(string: "http://127.0.0.1:8080/tasks")
        // Create a URLSession to handle the request tasks
        let session = URLSession.shared
        // Create a "data task" which will request some data from a URL and then run the completion handler that we are passing into the getAllPeople function itself
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    
    static func addTaskWithObjective(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "http://127.0.0.1:8080/tasks") {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method to POST
            request.httpMethod = "POST"
            // Create some bodyData and attach it to the HTTPBody
            let bodyData = "objective=\(objective)"
            request.httpBody = bodyData.data(using: .utf8)
            // Create the session
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
    
    static func updateTaskWithObjective(id: String, objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "http://127.0.0.1:8080/tasks/\(id)") {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method PUT to update
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            // Create some bodyData and attach it to the HTTPBody
            let bodyData = "{\"objective\" : \"\(objective)\"}"
            request.httpBody = bodyData.data(using: .utf8)
            // Create the session
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
    
    static func deleteTaskWithObjective(id: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Create the url to request
        if let urlToReq = URL(string: "http://127.0.0.1:8080/tasks/\(id)") {
            // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
            var request = URLRequest(url: urlToReq)
            // Set the method to DELETE
            request.httpMethod = "DELETE"
            // Create the session
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
}

//Data Struct from the API
struct dataModel {
    var id: String
    var task: String
    var date: String
}
