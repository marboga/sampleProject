//
//  CompletedBeastsController.swift
//  BeltExam
//
//  Created by Michael Arbogast on 5/20/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit
import CoreData

class CompletedBeastController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
 
    
    @IBOutlet weak var completedTableView: UITableView!
    
    let app = (UIApplication.sharedApplication().delegate as! AppDelegate)
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var completedBeasts: [Beast] = []

    override func viewDidLoad() {
        print("in completed tab")
        super.viewDidLoad()
        completedTableView.delegate = self
        completedTableView.dataSource = self
        getCompleteBeasts()
        completedTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        getCompleteBeasts()
        completedTableView.reloadData()
    }

    //RETRIEVE COMPLETE BEASTS
    func getCompleteBeasts() {
        let fetchRequest = NSFetchRequest(entityName: "Beast")
        print("retrieving")
        do {
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Beast] {
                completedBeasts = []
                print(results.count, "RESults count")
                for i in 0..<results.count {
//                    print(results[i].completed)
                    if results[i].completed == 1 {
                        completedBeasts.append(results[i])
                        print("appending", i)
                    }
                    print("got here before breaking")
                }
            }
        } catch {
            print("retrieval error")
        }
    }

    //CREATE ROWS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(completedBeasts.count, "count")
        return completedBeasts.count
    }
    
    //CREATE CELLS
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("in cell generator", completedBeasts)
        let cell = tableView.dequeueReusableCellWithIdentifier("beast_complete_cell") as! BeastCompleteCell
//        print(cell, "cell")
        cell.titleLabel.text = completedBeasts[indexPath.row].name
        let formatter = NSDateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEE MMM d.")
//        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
//
        cell.dateLabel.text = formatter.stringFromDate(completedBeasts[indexPath.row].completed_at!)
        
        return cell
    }
    
    
    //DELETE BY SWIPING
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            managedObjectContext.deleteObject(completedBeasts[indexPath.row])
            app.saveContext()
            completedBeasts.removeAtIndex(indexPath.row)
            
        }
        getCompleteBeasts()
        completedTableView.reloadData()
    }
    
    
    
    
    
}


