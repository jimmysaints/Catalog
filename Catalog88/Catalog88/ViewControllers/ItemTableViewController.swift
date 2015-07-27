//
//  ItemTableViewController.swift
//  Synergy88Catalog
//
//  Created by Admin MacBook Pro on 7/16/15.
//  Copyright © 2015 elidc93. All rights reserved.
//

import UIKit
import CoreData

class ItemTableViewController: UITableViewController {
    
    //var items: [String] = ["House Targaryen", "House Baratheon", "House Stark", "House Lannister", "House Tyrell", "House Arryn", "House Martell"]
    var items = [NSManagedObject]()
    let itemTableViewCellTag = 1
    let itemTableViewCellId = "Cell"
    var selectedItem = Item()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Item List"
        let nib = UINib(nibName: "ItemTableView", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        let addBarButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Add,
            target: self,
            action: "performAdd:")
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Item")
        var error: NSError?
        //TODO know the limit of fetch
        let fetchedResults = managedContext?.executeFetchRequest(
            fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            items = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    
        self.tableView.reloadData()
    }
    
    // Custom Methods
    
    func performAdd(sender: UIBarButtonItem) {
        println("Perform Add")
        performSegueWithIdentifier("addSegue", sender: self)
    }
    
    // Table View Delegate
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 48.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //   println("\(self.items[indexPath.row])")
        //self.selectedItem = self.items[indexPath.row] as! Item
        performSegueWithIdentifier("editSegue", sender: self)
    }
    
    // Table View DataSource
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(itemTableViewCellId, forIndexPath: indexPath) as! UITableViewCell
        let cellLabel = cell.viewWithTag(itemTableViewCellTag) as! UILabel
        cellLabel.text = self.items[indexPath.row].valueForKey("name") as? String
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ModifyItemViewController
        if (segue.identifier == "addSegue") {
            vc.modifyItemMode = false
            vc.selectedItem = self.selectedItem
            println("addSegue")
        } else if (segue.identifier == "editSegue") {
            vc.modifyItemMode = true
            println("editSegue")
        } else if (segue.identifier == "detailSegue") {
            println("detailSegue")
        }
    }
    
}

