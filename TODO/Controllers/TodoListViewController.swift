//
//  ViewController.swift
//  TODO
//
//  Created by Tarun Tyagi on 12/26/18.
//  Copyright © 2018 Tarun Tyagi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        print(dataFilePath)
        let newItem = Item()
        newItem.title = "find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "find Mike 2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "find Mike 3"
        itemArray.append(newItem3)
        
                if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
                    itemArray = items
                }
        
      
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done  ? .checkmark : .none
       
        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
       
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFieldValue = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add Item Button
            let newItem = Item()
            newItem.title = textFieldValue.text!
            self.itemArray.append(newItem)
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

