//
//  ViewController.swift
//  BeltExam
//
//  Created by Michael Arbogast on 5/20/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellTodoDelegate {

    @IBOutlet weak var tableview: UITableView!
    
    let app = (UIApplication.sharedApplication().delegate as! AppDelegate)
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    var beastsToComplete = [Beast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        getIncompleteBeasts()
        tableview.reloadData()
    }
    
//ADD BUTTON
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("AddBeastSegue", sender: nil)
    }
    
//EDIT BY CLICKING ON ROW
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(self, "ROW clicked upon")
        performSegueWithIdentifier("EditBeastSegue", sender: tableview.cellForRowAtIndexPath(indexPath))
    }
//DELETE BY SWIPING
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            managedObjectContext.deleteObject(beastsToComplete[indexPath.row])
            app.saveContext()
            beastsToComplete.removeAtIndex(indexPath.row)
            
        }
        getIncompleteBeasts()
        tableview.reloadData()
    }
    
//PREPARE 4 SEGUE
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddBeastSegue" {
            let controller = segue.destinationViewController as! AddBeastViewController
            controller.delegate = self
        } else if segue.identifier == "EditBeastSegue" {
            let controller = segue.destinationViewController as! AddBeastViewController
            controller.delegate = self
            if let indexPath = tableview.indexPathForCell(sender as! BeastCell) {
                print(indexPath, "indexpath")
                controller.beastToEdit = beastsToComplete[indexPath.row]
            }
        }
    }
    
//GET INCOMPLETE BEASTS
    func getIncompleteBeasts() {
        let fetchRequest = NSFetchRequest(entityName: "Beast")
        do {
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Beast] {
                print(results)
                beastsToComplete = []
                for i in 0..<results.count {
                    if results[i].completed == false {
                        beastsToComplete.append(results[i])
                    }
                }
            }
        } catch {
            print("retrieval error")
        }
    }
    
    
    //CREATE ROWS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beastsToComplete.count
    }
    
    //CREATE CELLS
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("beast_todo_cell") as! BeastCell
        cell.originalView = self
        cell.titleLabel.text = beastsToComplete[indexPath.row].name
        
        return cell
    }

    func setComplete(thisCell: BeastCell) {
        print("here")
        
    }
    
    //DELEGATE FUNCTIONS
    
    func doneDelegateFunction(name: String) {
        print("here?")
        let entity = NSEntityDescription.entityForName("Beast", inManagedObjectContext: managedObjectContext)
        let beast = Beast(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        
        beast.name = name
        beast.created_at = NSDate()
        app.saveContext()
        self.navigationController?.popViewControllerAnimated(true)
        getIncompleteBeasts()
        tableview.reloadData()
        
    }
    
    func editDelegateFunction(controller: AddBeastViewController, beast: Beast) {
        print("made this happen")
        self.navigationController?.popViewControllerAnimated(true)
        app.saveContext()
        tableview.reloadData()
    }
    
    func cancelDelegateFunction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
}

