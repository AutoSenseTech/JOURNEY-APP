//
//  TraveledViewController.swift
//  journayDemo
//
//  Created by Wang Weihan on 4/14/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//
import CoreData
import UIKit

class TraveledViewController: UIViewController {

   // @IBOutlet weak var traveledSegment: UISegmentedControl!
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    //let completedTitle = ["Cinque Terre","Great Wall"]
    var completedTitle = [String]()
    
    //let completedRessdesc = ["Italy","China"]
    var completedCountry = [String]()
    
    let completedDate = ["3/23/16"]
    //var completedDate = [NSDate]()
    
    //let completedpageTitle = ["Cinque Terre","Great Wall"]

    var trails: [NSManagedObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trails = SetupCoreData.loadTrails()
        //var addShit = true
        for trail in trails! {
            if trail.value(forKey: "state")! as! String == "Completed" {
                completedTitle.append(trail.value(forKey: "trailName") as! String)
                //completedDate.append(trail.valueForKey("dateCompleted") as! NSDate)
            }
        }
        let path = Bundle.main.path(forResource: "Trails", ofType: "plist")
        let trailsPlist = NSDictionary(contentsOfFile: path!)
        if let items = trailsPlist?.allValues {
            for item in items {
                if let theItem = item as? NSDictionary {
                    for title in completedTitle {
                        if theItem.value(forKey: "name") as! String == title {
                            completedCountry.append(theItem.value(forKey: "location") as! String)
                        }
                    }
                }
            }
        }

        // self.title = myTitle
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // var valuecount = 0
        
        return completedTitle.count
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        var myCell : UITableViewCell?
        
        let myCell1 = myTableView.dequeueReusableCell(withIdentifier: "completedCell", for: indexPath) as! CompletedCellTableViewCell
        
        myCell1.completed_Image.image = UIImage(named: "trail0.jpg")
        myCell1.location?.text = completedTitle[(indexPath as NSIndexPath).row]
        myCell1.country?.text  = completedCountry[(indexPath as NSIndexPath).row]
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM/dd/yy"
        
        myCell1.time?.text = completedDate[(indexPath as NSIndexPath).row]
        //myCell1.time?.text = dateformatter.stringFromDate(completedDate[indexPath.row])
        myCell1.accessoryType = .disclosureIndicator
        myCell = myCell1
        
        
        return myCell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if let destinationController = segue.destinationViewController as? CompletedTableViewController{
            
            destinationController.myTitle = completedTitle[myTableView.indexPathForSelectedRow!.row]
            if let row = self.myTableView.indexPathForSelectedRow?.row {
                destinationController.index = row
            }
        }*/
        if let destinationController = segue.destination as? TrailViewController{
            
            destinationController.myTitle = completedTitle[(myTableView.indexPathForSelectedRow! as NSIndexPath).row]
            if let row = (self.myTableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                destinationController.index = row
                destinationController.trailName = completedTitle[(myTableView.indexPathForSelectedRow! as NSIndexPath).row]
                destinationController.previousController = "Traveled"
            }
        }
    }
    
    @IBAction func segmentedControllAction(_ sender: AnyObject) {
        myTableView.reloadData()
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
