//
//  ViewController.swift
//  Todoey
//
//  Created by Kahwai Lee on 27/1/19.
//  Copyright © 2019 Kahwai Lee. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{
    let realm=try! Realm()
    var todoitems:Results<Item>?
    
//    let dataFilePath=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
            
    
        }
    }
    
   // let defaults=UserDefaults.standard    deleting this code to create own plist using encoder

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        print("Viewdidload")

        tableView.sectionIndexBackgroundColor=UIColor.gray

        //loadItem()

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
        tableView.separatorColor=UIColor.brown
       // tableView.backgroundColor=UIColor.purple
        
        if let item=todoitems?[indexPath.row]{
            print("checked go in")
            cell.textLabel?.text=item.title  // accesssing the properties using .title
            cell.accessoryType = item.done ? .checkmark : .none
//            if item.done==true{
//                            cell.accessoryType = .checkmark
//                        }else{
//                            cell.accessoryType = .none
//                        }
            
            //checking the mark such that when u scroll down reflect the checkmark and wont repeat
            //using ternary operator to shorten the below true false statement
            
            //value =condition ? valueiftrue : valueiffalse
        }else{
            cell.textLabel?.text="No item added"
        }
        
        
        //assign NS manageobject at index 0,1,....n
      
//        if item.done==true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
//
        return cell
        
        
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        print("Caneditrow")
//        return true
//    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        print("delete")
//        //let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
//
//        //let item=itemArray[indexPath.row]
//
//        if editingStyle == .delete{
//                  context.delete(todoitems[indexPath.row])
//
//                  todoitems.remove(at: indexPath.row)
//
//                  saveItem()
//        }
//
    
    
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count array")
        return todoitems?.count ?? 1  // feedback to indexpath row to let it call how many times
    }
    
    
    //MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        print("didselectrow")
        
        if let item=todoitems?[indexPath.row]{
            do{
            try realm.write {
                item.done = !item.done
            }
            }catch{
                print("Error saving checked state \(error)")
            }
        }
        tableView.reloadData()
//        todoitems?[indexPath.row].done = !todoitems?[indexPath.row].done // using not operator to reverse the command below
//        saveItem()
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
    
//    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "Confirm to delete?"
//    }
    
    // MARK - ADD new Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        print("add button click")
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when user pressed add item button
            //print(textField.text)
            
            let newItem=Item() //initialize object to item class
            
            if let currentCategory=self.selectedCategory{
                do{
               try self.realm.write{
                    newItem.title=textField.text!
                    newItem.dataCreated=Date()
                
                  //  newItem.done=false  no need as default as false in class
                    currentCategory.items.append(newItem)
                
                
                }
                }catch{
                    print("Error saving new items, \(error)")
                }
                self.tableView.reloadData()
        
            
    
        }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create new item" // background instruction on text field
            textField=alertTextField
            print(alertTextField.text!)
        }
        
        alert.addAction(action)// add action on the pop
        
        self.present(alert, animated: true , completion: nil) // pop out the alert on screen
    
    

}
    //MARK -MODEL MANIPULATION METHOD
//    func saveItem(){
//        print("Save item")
//        do {
//           try context.save()
//
//        }catch{
//            print("Error saving context, \(error)")
//        }
//
//
//
//        // self.defaults.set(self.itemArray, forKey: "TodoListArray")// forKey defaults database key into plist in local drive
//
//        self.tableView.reloadData()
//
//    }
    
func loadItems(){
      
    print("Load Item")
    todoitems=selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

    tableView.reloadData()
}
    
    

    
 
}
 //MARK -Searchbar method
extension TodoListViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoitems=todoitems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dataCreated", ascending: true)
        
//        let request:NSFetchRequest<Item>=Item.fetchRequest()   //query the database and return item of array //declare a constanst-->entity
//
//        let predicate=NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.predicate=predicate
//
//        let sortDescriptor=NSSortDescriptor(key: "title", ascending: true)
//
//        request.sortDescriptors=[sortDescriptor]
//
//        loadItem(with: request, predicate: predicate)

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Searchbardidchange")
        if searchBar.text?.count==0{
            loadItems()  // will reset the filter by calling loaditems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }

    }
}
   
    
    

