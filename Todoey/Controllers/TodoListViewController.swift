//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Pinar Unsal on 2018-08-12.
//  Copyright © 2018 S Pinar Unsal. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        print(dataFilePath)
        
        //Load plist array
        loadItems()
    }

    //MARK - Tableview DataSource Methods
    //Create table cells as many as itemArray.count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        
        //Ternary Operator
        //value = condition ? valueIfTrue : valueFalse
        cell.accessoryType = item.done ? .checkmark : .none
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print which cell we selected in the itemArray
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey List Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UIAlert
            //if the text is empty, it's gonna be set to an empty string
            print("Success! I am in action.")
            print(textField.text as Any)
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.saveItems()

            
        }
        
        //Closure - add alert text field
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        //Show the alert
        present(alert, animated: true, completion: nil)
    }
    //MARK - Model Manupulation Methods
    func saveItems () {
        //Encode itemArray into item.plist
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            //Decode itemArray from item.plist
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
            print("Error decoding item array, \(error)")
            }
        }
    }
}




























