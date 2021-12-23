//
//  AddItemsDelegate.swift
//  BucketListcrUD
//
//  Created by admin on 12/12/2021.
//

import UIKit

protocol AddItemDelegate: AnyObject {
    func addNewItem(item: String, at indexPath: NSIndexPath?)
}
