//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Kahwai Lee on 5/2/19.
//  Copyright © 2019 Kahwai Lee. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController  {
    
let realm=try! Realm() //use realm
var Categories:Results<Category>?  //container declaration for realm

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewdidloadCategory")
        loadCategory()
        tableView.rowHeight=80
        tableView.separatorStyle = .none
        
        




        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("add button click")
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add New Category ", message: "", preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen when user pressed add item button
            //print(textField.text)
            
        
            let newCategory=Category() //initialize object
            let hex=UIColor.randomFlat.hexValue()
            newCategory.name=textField.text!
            newCategory.hexValue=hex

            
//            newItem.title=textField.text!
//            newItem.done=false
//
           // self.CategoryArray.append(newCategory) autoupdate container for realm
            
            self.saveCategory(category: newCategory)
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create new Category" // background instruction on text field
            textField=alertTextField
            print(alertTextField.text!)
        }
        
        alert.addAction(action)// add action on the pop
        
        present(alert, animated: true , completion: nil) // pop out the alert on screen
        
    }
    
    //MARK- tableview datasource method
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=super.tableView(tableView, cellForRowAt: indexPath) //from superclass swipe table 
        print("Categorycellforrow")
        
        if let category=Categories?[indexPath.row]  {//assign value of container
        
            cell.textLabel?.text=category.name
        
            guard let categoryColour=UIColor(hexString: category.hexValue) else {
                fatalError()}
                
            
        cell.backgroundColor = categoryColour
        cell.textLabel?.textColor=UIColor(contrastingBlackOrWhiteColorOn: categoryColour, isFlat: true)
        }
       

        
        //checking the mark such that when u scroll down reflect the checkmark and wont repeat
        //using ternary operator to shorten the below true false statement
        
        //value =condition ? valueiftrue : valueiffalse
      //  cell.accessoryType = item.done==true ? .checkmark : .none
        
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
        return Categories?.count ?? 1  // feedback to indexpath row to let it call how many times
        // categories is optional if nil will return 1
    }
        

    
    
    
    
    //MARK -tableview delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
//        tableView.deselectRow(at: indexPath, animated: true)// deselect the row after turning grey and toggle back to white
          print("didselectrowCategory")
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
//        saveCategory()
//
//        tableView.deselectRow(at: indexPath, animated: true)// deselect the row after turning grey and toggle back to white
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("UIStoryboardSegue")
        let destinationVC=segue.destination as! TodoListViewController
        
        if let indexPath=tableView.indexPathForSelectedRow{
            print("AssignselectedCategory TO todolisteVC")
            destinationVC.selectedCategory=Categories?[indexPath.row]
            destinationVC.hex=(Categories?[indexPath.row].hexValue)!
        }
    }
    
    
    //MARK-Data manipulation method
    func saveCategory(category:Category){
        print("Save item")
        do {
            try realm.write {
                realm.add(category)
            }
            
        }catch{
            print("Error saving context, \(error)")
        }
        
        
        // self.defaults.set(self.itemArray, forKey: "TodoListArray")// forKey defaults database key into plist in local drive
        
        self.tableView.reloadData()
        
    }
    
    func loadCategory(){   //loaditem(external internal)
       
        print("Load ItemCategory")
        
        Categories=realm.objects(Category.self)
    
        tableView.reloadData()
    }
    
    
    override func updateModel(at indexPath: IndexPath) {
        let category=self.Categories?[indexPath.row]//assign result container property
        
        if let categoryForDeletion=category{  //optinal biding
            do{
             try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            }catch{
                print("Error deleting category ,\(error)")
            }
        
                        //  tableView.reloadData()
            }
    }
    

    
}

//MARK : SwipeTableViewCellDelegate


    

