//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Pinar Unsal on 2018-11-02.
//  Copyright © 2018 S Pinar Unsal. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    var cell: UITableViewCell?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 78.0
        tableView.separatorStyle = .none
    }
    
    //TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        //let longPressedGesture = UIGestureRecognizer(target: self, action: #selector(editModel(_:)))

        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        /***********************/
        let editAction = SwipeAction(style: .default, title: "Edit") { (action, indexPath) in
            print("ediItems")
            self.editModel(at: indexPath)
          
        }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in

            //print("Delete Cell")
            self.updateModel(at: indexPath)
        }
        
        editAction.image = UIImage(named: "flag-icon")
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
    func updateModel(at indexPath: IndexPath) {
        //Update data model
    }
    
    /**********************************************************/

    func editModel(at indexPath: IndexPath) {
        //Edit data model
    }
}
