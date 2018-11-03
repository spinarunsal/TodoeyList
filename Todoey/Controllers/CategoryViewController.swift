//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Pinar Unsal on 2018-09-26.
//  Copyright © 2018 S Pinar Unsal. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor(hexString: "ffffff")
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : FlatWhite()]
        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nil Coalescing Operator
        //if categories is nil return 1
         return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Tap into the cell created inside super view
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            //Add colors to cell and persist its color
            cell.textLabel?.text = category.name
            guard let categoryColour = UIColor(hexString: category.colour) else { fatalError() }
            cell.backgroundColor = categoryColour
            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
            
        }
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row] 
        }
    }
    
    //MARK: - Data Manipulation Methods
    func save(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(){
        //pull out all items inside realm that are of category obj
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    //MARK: Delete data from swipe
    override func updateModel(at indexPath: IndexPath) {
        //super.updateModel(at: indexPath)
        //handle action by updating model with deletion
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error Deleting Category \(error)")
            }
        }
    }
    
    //MARK: - Edit data from swipe
    override func editModel(at indexPath: IndexPath) {
        var task = UITextField()
        let alert = UIAlertController(title: "Edit Category Name", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Modify", style: .default, handler: { (action) in
            if let item = self.categories?[indexPath.row]{
                do {
                    try self.realm.write {
                        item.name = "\(task.text ?? "")"
                    }
                } catch {
                    print("Error Updating Item Name: \(error)")
                }
            }
            self.tableView.reloadData()
        })
        alert.addTextField { (alertTextField) in
            task = alertTextField
            task.placeholder = "New Item Title"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Add New Categories

    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat.hexValue()
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
    }
}
