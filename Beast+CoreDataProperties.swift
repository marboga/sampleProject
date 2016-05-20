//
//  Beast+CoreDataProperties.swift
//  BeltExam
//
//  Created by Michael Arbogast on 5/20/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Beast {

    @NSManaged var name: String?
    @NSManaged var completed: NSNumber?
    @NSManaged var completed_at: NSDate?
    @NSManaged var created_at: NSDate?

}
