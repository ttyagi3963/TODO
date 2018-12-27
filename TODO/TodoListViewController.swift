//
//  ViewController.swift
//  TODO
//
//  Created by Tarun Tyagi on 12/26/18.
//  Copyright © 2018 Tarun Tyagi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["find mike", "Kiss Hind", "Love Hind"]
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
      
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
       
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
             tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
            {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFieldValue = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add Item Button
            self.itemArray.append(textFieldValue.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new Item"
            textFieldValue = alertTextField
            print(alertTextField)
        }
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
        
    }
    
}

