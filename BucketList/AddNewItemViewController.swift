//
//  ViewController.swift
//  BucketListcrUD
//
//  Created by admin on 12/12/2021.
//

import UIKit

class AddNewItemViewController: UITableViewController {

    weak var delegate: AddItemDelegate?
    @IBOutlet weak var itemTextField: UITextField!
    var item: String?
    var indexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTextField.text = item
    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let item = itemTextField.text else { return }
        let alert = UIAlertController(title: "Error", message: "Please Enter Valid Value", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in return}))
        alert.view.backgroundColor = .red
        if item.isEmpty {
            present(alert, animated: true, completion: nil)
        }
        else {
            delegate?.addNewItem(item: item, at: indexPath)
            dismiss(animated: true, completion: nil)
        }
    }
    
}

