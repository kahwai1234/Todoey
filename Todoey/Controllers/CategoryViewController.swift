//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Kahwai Lee on 5/2/19.
//  Copyright © 2019 Kahwai Lee. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {
    
var CategoryArray=[Category]()
let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext  //grab the persistent container context for CRUD

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewdidloadCategory")
        loadCategory()


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
        
            let newCategory=Category(context: self.context) //initialize DS manage object
            
            newCategory.name=textField.text!
            
        
            
            
//            newItem.title=textField.text!
//            newItem.done=false
//
            self.CategoryArray.append(newCategory)
            
            self.saveCategory()
            
            
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        print("Categorycellforrow")
        
        let category=CategoryArray[indexPath.row]
        
        cell.textLabel?.text=category.name
        
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
        return CategoryArray.count  // feedback to indexpath row to let it call how many times
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
            destinationVC.selectedCategory=CategoryArray[indexPath.row]
        }
    }
    
    
    //MARK-Data manipulation method
    func saveCategory(){
        print("Save item")
        do {
            try context.save()
            
        }catch{
            print("Error saving context, \(error)")
        }
        
        
        // self.defaults.set(self.itemArray, forKey: "TodoListArray")// forKey defaults database key into plist in local drive
        
        self.tableView.reloadData()
        
    }
    
    func loadCategory(with request : NSFetchRequest<Category>=Category.fetchRequest()){   //loaditem(external internal)
       
        
        //let request:NSFetchRequest<Item>=Item.fetchRequest()
        print("Load ItemCategory")
        do {
            CategoryArray=try context.fetch(request)
            
        }catch{
            print("Error in fetching data from context,\(error)")
        }
        tableView.reloadData()
    }
    
}
