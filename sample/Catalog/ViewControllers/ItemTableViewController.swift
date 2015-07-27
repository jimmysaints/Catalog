//
//  ItemTableViewController.swift
//  Synergy88Catalog
//
//  Created by Admin MacBook Pro on 7/16/15.
//  Copyright © 2015 elidc93. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    var items: [String] = ["House Targaryen", "House Baratheon", "House Stark", "House Lannister", "House Tyrell", "House Arryn", "House Martell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ItemTableView", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
        // Add Bar Button
        
        let addBarButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Add,
            target: self,
            action: "performAdd:")
        self.navigationItem.rightBarButtonItem = addBarButton
        
        // Title
        
        self.navigationItem.title = "Item List"
    }
    
    // Custom Methods
    
    func performAdd(sender: UIBarButtonItem) {
        print("fun times")
        performSegueWithIdentifier("addSegue", sender: self)
    }
    
    // Table View Delegate
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88.0
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("88")
    }
    
    // Table View DataSource
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let cellLabel = cell.viewWithTag(1) as! UILabel
        
        cellLabel.text = self.items[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addSegue") {
            print("addSegue")
        } else if (segue.identifier == "detailSegue") {
            print("detailSegue")
        }
    }
    
}

