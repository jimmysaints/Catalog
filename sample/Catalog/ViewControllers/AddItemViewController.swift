//
//  ViewController.swift
//  Synergy88Catalog
//
//  Created by Admin MacBook Pro on 7/16/15.
//  Copyright © 2015 elidc93. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController {
    
    let idTextFieldTag = 11
    let nameTextFieldTag = 22
    let descTextFieldTag = 33
    let photoImageViewTag = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        
        self.navigationItem.title = "Add Item"

        // Add Bar Button
        
        let saveBarButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Save,
            target: self,
            action: "performSave:")
        self.navigationItem.rightBarButtonItem = saveBarButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Custom Methods
    
    func performSave(sender: UIBarButtonItem) {

        
        let idTextField = self.view.viewWithTag(idTextFieldTag) as! (UITextField)
        let nameTextField = self.view.viewWithTag(nameTextFieldTag) as! (UITextField)
        let descTextField = self.view.viewWithTag(descTextFieldTag) as! (UITextField)
        // TODO add image here let nameTextField = self.view.viewWithTag(nameTextFieldTag)
        
        print("saving to db fun times \(idTextField.text) \(nameTextField.text) \(descTextField.text)")
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: managedObjectContext!)
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        item.setValue(idTextField.text, forKey: "id")
        item.setValue(nameTextField.text, forKey: "name")
        item.setValue(descTextField.text, forKey: "desc")
        
        var error: NSError?
        if managedObjectContext!.save(&error) {
            print("fun times greate")
        } else {
            print("Failed to populate the database. Error = \(error)")
        }
        
        //performSegueWithIdentifier("itemListSegue", sender: self)
    }
    
    
}

