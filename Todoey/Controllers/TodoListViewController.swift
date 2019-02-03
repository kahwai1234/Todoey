//
//  ViewController.swift
//  Todoey
//
//  Created by Kahwai Lee on 27/1/19.
//  Copyright © 2019 Kahwai Lee. All rights reserved.
//

import UIKit


class TodoListViewController: UITableViewController {
    
    var itemArray=[Item]() //array of "item" object
     let dataFilePath=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    
   // let defaults=UserDefaults.standard    deleting this code to create own plist using encoder

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       print("Viewdidload")
        
       
        print(dataFilePath)
        loadItem()
//        let newItem=Item()
//        newItem.title="Find Mike"
//        itemArray.append(newItem)
//
//        let newItem1=Item()
//        newItem1.title="Buy egg"
//        itemArray.append(newItem1)
//
//        let newItem3=Item()
//        newItem3.title="Buy egg"
//        itemArray.append(newItem3)
//
//        let newItem4=Item()
//        newItem4.title="Buy egg"
//        itemArray.append(newItem4)
//
        
//        if let items=defaults.array(forKey: "TodoListArray") as? [Item] {//extract plist on local drive
//            itemArray=items
//        }
        
    }
    
    //MARK - TableView Datasource Method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellforrow")
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item=itemArray[indexPath.row]
        cell.textLabel?.text=item.title
        
        //checking the mark such that when u scroll down reflect the checkmark and wont repeat
        //using ternary operator to shorten the below true false statement
        
        //value =condition ? valueiftrue : valueiffalse
        cell.accessoryType = item.done==true ? .checkmark : .none
        
//        if item.done==true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
//
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count array")
        return itemArray.count  // feedback to indexpath row to let it call how many times
    }
    
    
    //MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        print("didselectrow")
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done // using not operator to reverse the command below
        saveItem()
//        if itemArray[indexPath.row].done==false{
//            itemArray[indexPath.row].done=true
//        }else{
//            itemArray[indexPath.row].done=false
//        }

        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
        //tableView.reloadData()  //call the tableviewdatasource method , will reload the tableview by no of itemarray
        tableView.deselectRow(at: indexPath, animated: true)// deselect the row after turning grey and toggle back to white
    
    }
    
    // MARK - ADD new Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        print("add button click")
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when user pressed add item button
            //print(textField.text)
            let newItem=Item()
            newItem.title=textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItem()
          //  self.itemArray.append(textField.text!)
            
           
        }
        
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create new item" // background instruction on text field
            textField=alertTextField
            print(alertTextField.text!)
        }
        
        alert.addAction(action)// add action on the pop
        
        present(alert, animated: true , completion: nil) // pop out the alert on screen
    
    
}
    
    //MARK -MODEL MANIPULATION METHOD
    func saveItem(){
        let encoder=PropertyListEncoder()
        
        do {
            let data=try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        }catch{
            print("Error encoding itemarray, \(error)")
        }
        
        
        
        // self.defaults.set(self.itemArray, forKey: "TodoListArray")// forKey defaults database key into plist in local drive
        
        self.tableView.reloadData()
        
    }
    
    func loadItem(){
        if let data=try? Data(contentsOf: dataFilePath!){
            let decoder=PropertyListDecoder()
            do{
                itemArray=try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding itemarray, \(error)")
            }
            
        }
        
    }
    
}


