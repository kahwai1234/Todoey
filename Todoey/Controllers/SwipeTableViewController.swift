//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Kahwai Lee on 12/2/19.
//  Copyright © 2019 Kahwai Lee. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController , SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Swipe table viewdidload")
        tableView.rowHeight=80


    }
 // table cell for row cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        print("Swipetablecellforrow")
        
        cell.delegate=self  // declare as delegate to receive swipe and trigger swipe below
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            self.updateModel(at: indexPath)
//            // handle action by updating model with deletion
              print("SwipetableItem deleleted")
//
//
//
//
      }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "Trash Icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        print("Swipe delete")
        //options.transitionStyle = .border
        return options
    }

    
    func updateModel(at indexPath: IndexPath){
        //update our data model
    }


}
