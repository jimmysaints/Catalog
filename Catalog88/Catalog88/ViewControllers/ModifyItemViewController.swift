//
//  ViewController.swift
//  Synergy88Catalog
//
//  Created by Admin MacBook Pro on 7/16/15.
//  Copyright © 2015 elidc93. All rights reserved.
//

import UIKit
import CoreData

class ModifyItemViewController: UIViewController {
    
    let idTextFieldTag = 11;    let idKey = "id"
    let nameTextFieldTag = 22;  let nameKey = "name"
    let descTextFieldTag = 33;  let descKey = "desc"
    let photoImageViewTag = 44; let photoKey = "photo"
    
    let itemClassName = "Item"
    
    var modifyItemMode = false
    var selectedItem = Item()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add Bar Button
        let modifyBarButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Save,
            target: self,
            action: "performSave:")
        
        if (modifyItemMode) {
            self.title = "Modify Item"
            let idTextField = self.view.viewWithTag(idTextFieldTag) as! (UITextField)
            let nameTextField = self.view.viewWithTag(nameTextFieldTag) as! (UITextField)
            let descTextField = self.view.viewWithTag(descTextFieldTag) as! (UITextField)
            
            idTextField.text = selectedItem.id
            nameTextField.text = selectedItem.name
            descTextField.text = selectedItem.desc
        } else {
            self.title = "Add Item"
        }

        self.navigationItem.rightBarButtonItem = modifyBarButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Custom methods
    func performSave(sender: UIBarButtonItem) {
        
        let idTextField = self.view.viewWithTag(idTextFieldTag) as! (UITextField)
        let nameTextField = self.view.viewWithTag(nameTextFieldTag) as! (UITextField)
        let descTextField = self.view.viewWithTag(descTextFieldTag) as! (UITextField)
        // TODO add image here let nameTextField = self.view.viewWithTag(nameTextFieldTag)
        
        if (idTextField.text.isEmpty) {
            self.presentAlertController("Id") // won't happen
        } else if (nameTextField.text.isEmpty) {
            self.presentAlertController("Name")
        } else if (descTextField.text.isEmpty) {
            self.presentAlertController("Description")
        } else {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext!
            let entity = NSEntityDescription.entityForName(itemClassName, inManagedObjectContext: managedObjectContext)
            let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
            
            item.setValue(idTextField.text, forKey: idKey)
            item.setValue(nameTextField.text, forKey: nameKey)
            item.setValue(descTextField.text, forKey: descKey)
            // TODO item.setValue("c", forKey: "photo")
            
            var error: NSError?
            if managedObjectContext.save(&error) {
                println("Database Addition Succeed")
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                println("Database Error = \(error)")
            }
        }
    }
    
    private func presentAlertController(field: String) {
        var alert: UIAlertController = UIAlertController(
            title: "Catalog88",
            message: "\(field) field is empty",
            preferredStyle: .Alert)
        
        alert.addAction(
            UIAlertAction(
                title: "Dismiss",
                style: .Default,
                handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
//    TODO dummy image nsdata
//    let photo = NSData()
//    let itemValues = [idTextField.text, nameTextField.text, descTextField.text, photo]
//    private func checkValues(itemValues: [AnyObject]) -> Bool {
//        for v: AnyObject in itemValues {
//            if v is String {
//                if v.length == 0 {
//                    return false
//                }
//            } else if v is NSData {
//                if v.length == 0 {
//                    return false
//                }
//            }
//        }
//        return true
//    }
    
}

