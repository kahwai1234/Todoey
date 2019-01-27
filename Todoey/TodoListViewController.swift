//
//  ViewController.swift
//  Todoey
//
//  Created by Kahwai Lee on 27/1/19.
//  Copyright © 2019 Kahwai Lee. All rights reserved.
//

import UIKit


class TodoListViewController: UITableViewController {
    
    var itemArray=["Find Mike","Buy Eggos","Destroy Demogorgon"]
    
    let defaults=UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items=defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray=items
        }
        
    }
    
    //MARK - TableView Datasource Method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text=itemArray[indexPath.row]
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count  // feedback to indexpath row to let it call how many times
    }
    
    
    //MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
     
        
        
    }
    
    // MARK - ADD new Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when user pressed add item button
            //print(textField.text)
            
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")// forKey defaults database key
            
            self.tableView.reloadData()
        }
        
        
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create new item" // background instruction on text field
            textField=alertTextField
            //print(alertTextField.text!)
        }
        
        alert.addAction(action)// add action on the pop
        
        present(alert, animated: true , completion: nil) // pop out the alert on screen
        
    
    
    
}
}
