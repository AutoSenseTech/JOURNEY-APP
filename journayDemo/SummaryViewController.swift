//
//  SummaryViewController.swift
//  journayDemo
//
//  Created by MU IT Program on 5/4/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit
import CoreData

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var futureTrails: UILabel!
    @IBOutlet weak var inProgressTrails: UILabel!
    @IBOutlet weak var completedTrails: UILabel!
    @IBOutlet weak var averageDistancePerDay: UILabel!
    
    var tDistance = 0
    var tTime = 0
    var fTrails = 0
    var ipTrails = 0
    var cTrails = 0
    
    var trails: [NSManagedObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trails = SetupCoreData.loadTrails()
        for trail in trails! {
            tDistance += trail.value(forKey: "totalMiles") as! NSInteger
            tTime += trail.value(forKey: "timeSpent") as! NSInteger
            if trail.value(forKey: "state")! as! String == "InProgress" {
                ipTrails += 1
            }
            if trail.value(forKey: "state")! as! String == "Future" {
                fTrails += 1
            }
            if trail.value(forKey: "state")! as! String == "Completed" {
                cTrails += 1
            }
        }
        
        totalDistance.text = "Total Distance: " + String(tDistance) + " miles"
        totalTime.text = "Total Time: " + String(tTime) + " days"
        averageDistancePerDay.text = "Average Distance per Day: " + String(tDistance/tTime) + " miles"
        futureTrails.text = "Trails Not Started: " + String(fTrails)
        inProgressTrails.text = "Trails In-Progress: " + String(ipTrails)
        completedTrails.text = "Total Trails Completed: " + String(cTrails)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
