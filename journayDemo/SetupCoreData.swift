//
//  SetupCoreData.swift
//  journayDemo
//
//  Created by MU IT Program on 5/3/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class SetupCoreData {

    static func setup()
    {
        loadTrails()
        if entityIsEmpty("Trail")
        {
            var thisTrail: NSManagedObject?
            
            let path = Bundle.main.path(forResource: "Trails", ofType: "plist")
            let trails = NSDictionary(contentsOfFile: path!)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            if let items = trails?.allValues {
                for item in items {
                    if let theItem = item as? NSDictionary {
                        let name = theItem.value(forKey: "name") as! String
                        
                        print(name)
                        
                        let trailEntity =  NSEntityDescription.entity(forEntityName: "Trail", in:   managedContext)
                        thisTrail = NSManagedObject(entity: trailEntity!, insertInto:managedContext)
                        
                        //for testing purposes only
                        if name == "Great Wall" {
                            thisTrail?.setValue(name, forKey: "trailName")
                            thisTrail?.setValue("InProgress", forKey: "state")
                            thisTrail?.setValue(342, forKey: "timeSpent")
                            thisTrail?.setValue(6685, forKey: "totalMiles")
                        }
                        else if name == "Appalachian Trail" {
                            thisTrail?.setValue(name, forKey: "trailName")
                            thisTrail?.setValue("Completed", forKey: "state")
                            thisTrail?.setValue(98, forKey: "timeSpent")
                            thisTrail?.setValue(2200, forKey: "totalMiles")

                        }else{
                        
                        //^^^^ Testing
                        
                            thisTrail?.setValue(name, forKey: "trailName")
                            thisTrail?.setValue("Future", forKey: "state")
                            thisTrail?.setValue(0, forKey: "timeSpent")
                            thisTrail?.setValue(0, forKey: "totalMiles")
                        }
                        
                        do {
                            try managedContext.save()
                        } catch let error as NSError {
                            print("Could not save \(error), \(error.userInfo)")
                        }
                    }
                }
            }
        }
    }
    static func entityIsEmpty(_ entity: String) -> Bool
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: entity)
        var results : NSArray?
        
        do {
            results = try managedContext.fetch(request) as! [NSManagedObject]
            
            return results!.count == 0
            
        } catch let error as NSError {
            // failure
            print("Error: \(error.debugDescription)")
            return true
        }
    }
    static func loadTrails() -> [NSManagedObject]?
    {
        // Load saved note entities from core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Trail")
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults {
                return results
            } else {
                print("Could not fetch trails")
            }
        } catch {
            return nil
        }
        return nil
    }
    
}
