//
//  TaskModel.swift
//  BucketList
//
//  Created by admin on 23/12/2021.
//

import Foundation
class TaskModel {
    // Note that we are passing in a function (similar to our use of callbacks in JS). This function will allow the ViewController that calls this method to dictate what runs upon completion.copy
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Specify the API that we will be sending the Request to
        let url = URL(string: "http://127.0.0.1:8080/tasks")
        // Create a URLSession to handle the request tasks
        let session = URLSession.shared
        // Create a "data task" which will request some data from a URL and then run the completion handler that we are passing into the getAllPeople function itself
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
}

//Data Struct from the API
struct dataModel {
    var id: String
    var task: String
    var date: String
}
