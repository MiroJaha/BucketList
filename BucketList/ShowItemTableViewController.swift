//
//  ViewController.swift
//  BucketList
//
//  Created by admin on 23/12/2021.
//

import UIKit

class ShowItemTableViewController: UITableViewController {
    
    var list = [dataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }
    
    func fetchAllItems() {
        list.removeAll()
        TaskModel.getAllTasks() {
       //passing what becomes "completionHandler" in the 'getAllPeople' function definition in StarWarsModel.swift
            data, response, error in
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                guard let data = data else {
                    print("No Data")
                    return
                }
                if let results = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                    results.forEach { result in
                        let task = result as! NSDictionary
                        // Appending data to my array to be displayed in my table view
                        self.list.append(
                            dataModel(
                                id: task["id"] as! String,
                                task: task["objective"] as! String,
                                date: task["createdAt"] as! String
                            )
                        )
                    }
                    DispatchQueue.main.sync { [self] in
                        tableView.reloadData()
                    }
                }
            } catch {
                print("Something went wrong")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = list[indexPath.section].task
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "AddSegue", sender: indexPath)
    }
    
    //Delete Functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id = list[indexPath.section].id
        TaskModel.deleteTaskWithObjective(id: id) { data, response, error in
            if let error = error {
                print(error)
            }else {
                print("Deleted Successfully")
            }
            DispatchQueue.main.sync {
                self.fetchAllItems()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! UINavigationController
        let newViewController = destination.topViewController as! AddNewItemViewController
        newViewController.delegate = self
        if let indexPath = sender as? NSIndexPath {
            newViewController.item = list[indexPath.section].task
            newViewController.indexPath = indexPath
        }
    }
}
    
extension ShowItemTableViewController: AddItemDelegate {
    //Add and Update Functionality
    func addNewItem(item: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            let id = list[ip.section].id
            TaskModel.updateTaskWithObjective(id: id, objective: item) { data, response, error in
                if let error = error {
                    print(error)
                }else {
                    print("Updated Successfully")
                }
                DispatchQueue.main.sync {
                    self.fetchAllItems()
                }
            }
        }
        else {
            TaskModel.addTaskWithObjective(objective: item) { data, response, error in
                if let error = error {
                    print(error)
                }else {
                    print("Add Successfully")
                }
                DispatchQueue.main.sync {
                    self.fetchAllItems()
                }
            }
        }
    }
}
