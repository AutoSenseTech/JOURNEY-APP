//
//  TrekkingViewController.swift
//  journayDemo
//
//  Created by Wang Weihan on 3/28/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit
import CoreData

class TrekkingViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    
    var inprogessViewController: TrailViewController?
    var futureViewController:FutureViewController?
    
    var inProgressCount = 0
    var futureCount = 0
    
    var inProgressList = [String]()
    var futureList = [String]()
    
    //var inProgressTitle = ["Appalacian Trail","Camino de Santiago","Cinque Terre","Great Wall","Inca Trail"]
    var inProgressTitle = [String]()
    
    //let inProgressdesc = ["United States","Spain","Italy","China","Peru"]
    var inProgressCountry = [String]()
    
    
    //var progress = [56.5,67,34,89.7,12.8]
    var progress = [Float]()
    
    var completedMiles = [NSNumber]()
    var totalMiles = [NSNumber]()
    
    //let futureimageTitle = ["Appalacian Trail","Camino de Santiago","Cinque Terre","Great Wall","Inca Trail"]
    var futureTitle = [String]()
    
    //let futureimagedesc = ["United States","Spain","Italy","China","Peru"]
    var futureCountry = [String]()
    
    //let distance = ["Total Distance: 24.56 miles","Total Distance: 25.78 miles","Total Distance: 22.45 miles","Total Distance: 14.56 miles","Total Distance: 9.44 miles"]
    var futureTotalDistance = [String]()
    
    var latitdue = [45.900203,42.939643,44.134933,40.443088,34.064379]
    var longtitude = [-68.929428,-8.680727,9.684851,116.558218,-118.567961]
    //dont think we need nameofstation anymore
    var nameofstation = ["stations1","stations2","stations3","stations4","stations5"]
    
    var trails: [NSManagedObject]?
    
    var loaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupCoreData.setup()
        
       // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //let managedContext = appDelegate.managedObjectContext
        trails = SetupCoreData.loadTrails()
        //var addShit = true
        for trail in trails! {
            if trail.value(forKey: "state")! as! String == "InProgress" {
                inProgressCount+=1
                inProgressTitle.append(trail.value(forKey: "trailName") as! String)
                completedMiles.append(NSNumber((trail.value(forKey: "totalMiles")) as! NSInteger))
                
            } else if trail.value(forKey: "state") as! String == "Future" {
                futureCount+=1
                futureTitle.append(trail.value(forKey: "trailName") as! String)
            }
        }
        let path = Bundle.main.path(forResource: "Trails", ofType: "plist")
        let trailsPlist = NSDictionary(contentsOfFile: path!)
        if let items = trailsPlist?.allValues {
            for item in items {
                if let theItem = item as? NSDictionary {
                    for title in inProgressTitle {
                        if theItem.value(forKey: "name") as! String == title {
                            inProgressCountry.append(theItem.value(forKey: "location") as! String)
                            totalMiles.append(theItem.value(forKey: "lengthmiles") as! NSNumber)
                        }
                    }
                    for title in futureTitle {
                        if theItem.value(forKey: "name") as! String == title {
                            futureCountry.append(theItem.value(forKey: "location") as! String)
                            futureTotalDistance.append("Total Distance: " + String(describing: theItem.value(forKey: "lengthmiles") as! NSNumber))
                        }
                    }
                }
            }
        }
        var i = 0
        while i < completedMiles.count {
            print(completedMiles[i].floatValue)
            print(totalMiles[i].floatValue)
            progress.append((completedMiles[i].floatValue/totalMiles[i].floatValue))
            i+=1
        }
        loaded = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if loaded {
            
            let prevIPCount = inProgressCount
            let prevFCount = futureCount
            
            inProgressCount = 0
            futureCount = 0
            
            inProgressList = []
            futureList = []
            inProgressTitle = []
            inProgressCountry = []
            progress = []
            completedMiles = []
            totalMiles = []
            futureTitle = []
            futureCountry = []
            futureTotalDistance = []
            
            trails = SetupCoreData.loadTrails()
            //var addShit = true
            for trail in trails! {
                if trail.value(forKey: "state")! as! String == "InProgress" {
                    inProgressCount+=1
                    inProgressTitle.append(trail.value(forKey: "trailName") as! String)
                    completedMiles.append(NSNumber((trail.value(forKey: "totalMiles")) as! NSInteger))
                    
                } else if trail.value(forKey: "state") as! String == "Future" {
                    futureCount+=1
                    futureTitle.append(trail.value(forKey: "trailName") as! String)
                }
            }
            let path = Bundle.main.path(forResource: "Trails", ofType: "plist")
            let trailsPlist = NSDictionary(contentsOfFile: path!)
            if let items = trailsPlist?.allValues {
                for item in items {
                    if let theItem = item as? NSDictionary {
                        for title in inProgressTitle {
                            if theItem.value(forKey: "name") as! String == title {
                                inProgressCountry.append(theItem.value(forKey: "location") as! String)
                                totalMiles.append(theItem.value(forKey: "lengthmiles") as! NSNumber)
                            }
                        }
                        for title in futureTitle {
                            if theItem.value(forKey: "name") as! String == title {
                                futureCountry.append(theItem.value(forKey: "location") as! String)
                                futureTotalDistance.append("Total Distance: " + String(describing: theItem.value(forKey: "lengthmiles") as! NSNumber))
                            }
                        }
                    }
                }
            }
            var i = 0
            while i < completedMiles.count {
                print(completedMiles[i].floatValue)
                print(totalMiles[i].floatValue)
                progress.append((completedMiles[i].floatValue/totalMiles[i].floatValue))
                i+=1
            }
           
            if prevIPCount != inProgressCount || prevFCount != futureCount {
                segmentedControl.selectedSegmentIndex = 0
            }
        }
        myTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var valuecount = 0
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            valuecount = inProgressCount
            break
        case 1:
            valuecount = futureCount
            break
        default:
            break
        }
        return valuecount
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        var myCell : UITableViewCell?
        
        if (segmentedControl.selectedSegmentIndex == 0) {
            // progress bar version of cell
            
            let myCell2 = tableView.dequeueReusableCell(withIdentifier: "myCell2", for: indexPath) as! MyCell2TableViewCell
            // do whatever you want on myCell1 knowing it is a MyCellTableViewCell
            //myCell2.
            if (inProgressTitle[(indexPath as NSIndexPath).row] == "Appalachian Trail"){
                myCell2.missionImage2.image = UIImage(named: "trail0.jpg")
                myCell2.imageTitle2?.text = inProgressTitle[(indexPath as NSIndexPath).row]
                myCell2.imageDescription2?.text = inProgressCountry[(indexPath as NSIndexPath).row]
                myCell2.progressview.progress = Float(progress[(indexPath as NSIndexPath).row])
                myCell2.accessoryType = .disclosureIndicator
                myCell = myCell2
            }
            else if (inProgressTitle[(indexPath as NSIndexPath).row] == "Inca Trail"){
                myCell2.missionImage2.image = UIImage(named: "trail4.jpg")
                myCell2.imageTitle2?.text = inProgressTitle[(indexPath as NSIndexPath).row]
                myCell2.imageDescription2?.text = inProgressCountry[(indexPath as NSIndexPath).row]
                myCell2.progressview.progress = Float(progress[(indexPath as NSIndexPath).row])
                myCell2.accessoryType = .disclosureIndicator
                myCell = myCell2
            }
            else if (inProgressTitle[(indexPath as NSIndexPath).row] == "Great Wall"){
                myCell2.missionImage2.image = UIImage(named: "trail3.jpg")
                myCell2.imageTitle2?.text = inProgressTitle[(indexPath as NSIndexPath).row]
                myCell2.imageDescription2?.text = inProgressCountry[(indexPath as NSIndexPath).row]
                myCell2.progressview.progress = Float(progress[(indexPath as NSIndexPath).row])
                myCell2.accessoryType = .disclosureIndicator
                myCell = myCell2
            }
            else if (inProgressTitle[(indexPath as NSIndexPath).row] == "Cinque Terre"){
                myCell2.missionImage2.image = UIImage(named: "trail2.jpg")
                myCell2.imageTitle2?.text = inProgressTitle[(indexPath as NSIndexPath).row]
                myCell2.imageDescription2?.text = inProgressCountry[(indexPath as NSIndexPath).row]
                myCell2.progressview.progress = Float(progress[(indexPath as NSIndexPath).row])
                myCell2.accessoryType = .disclosureIndicator
                myCell = myCell2
            }
            else{
                myCell2.missionImage2.image = UIImage(named: "trail1.jpg")
                myCell2.imageTitle2?.text = inProgressTitle[(indexPath as NSIndexPath).row]
                myCell2.imageDescription2?.text = inProgressCountry[(indexPath as NSIndexPath).row]
                myCell2.progressview.progress = Float(progress[(indexPath as NSIndexPath).row])
                myCell2.accessoryType = .disclosureIndicator
                myCell = myCell2
            }
            /*myCell2.missionImage2.image = UIImage(named: "trail\(indexPath.row).jpg")
            myCell2.imageTitle2?.text = inProgressTitle[indexPath.row]
            myCell2.imageDescription2?.text = inProgressCountry[indexPath.row]
            myCell2.progressview.progress = Float(progress[indexPath.row])
            myCell2.accessoryType = .DisclosureIndicator
            myCell = myCell2*/
            
        } else {

            let myCell1 = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCellTableViewCell
            // do whatever you want on myCell1 knowing it is a MyCellTableViewCell
            //myCell1.
            if(futureTitle[(indexPath as NSIndexPath).row] == "Appalachian Trail"){
                myCell1.missionImage.image = UIImage(named: "trail0.jpg")
                myCell1.imageTitle?.text = futureTitle[(indexPath as NSIndexPath).row]
                myCell1.imageDescription?.text = futureCountry[(indexPath as NSIndexPath).row]
                myCell1.distance?.text = futureTotalDistance[(indexPath as NSIndexPath).row] + " miles"
                myCell1.accessoryType = .disclosureIndicator
                myCell = myCell1
            }
            else if(futureTitle[(indexPath as NSIndexPath).row] == "Inca Trail"){
                myCell1.missionImage.image = UIImage(named: "trail4.jpg")
                myCell1.imageTitle?.text = futureTitle[(indexPath as NSIndexPath).row]
                myCell1.imageDescription?.text = futureCountry[(indexPath as NSIndexPath).row]
                myCell1.distance?.text = futureTotalDistance[(indexPath as NSIndexPath).row] + " miles"
                myCell1.accessoryType = .disclosureIndicator
                myCell = myCell1
            }
            else if(futureTitle[(indexPath as NSIndexPath).row] == "Great Wall"){
                myCell1.missionImage.image = UIImage(named: "trail3.jpg")
                myCell1.imageTitle?.text = futureTitle[(indexPath as NSIndexPath).row]
                myCell1.imageDescription?.text = futureCountry[(indexPath as NSIndexPath).row]
                myCell1.distance?.text = futureTotalDistance[(indexPath as NSIndexPath).row] + " miles"
                myCell1.accessoryType = .disclosureIndicator
                myCell = myCell1
            }
            else if(futureTitle[(indexPath as NSIndexPath).row] == "Cinque Terre"){
                myCell1.missionImage.image = UIImage(named: "trail2.jpg")
                myCell1.imageTitle?.text = futureTitle[(indexPath as NSIndexPath).row]
                myCell1.imageDescription?.text = futureCountry[(indexPath as NSIndexPath).row]
                myCell1.distance?.text = futureTotalDistance[(indexPath as NSIndexPath).row] + " miles"
                myCell1.accessoryType = .disclosureIndicator
                myCell = myCell1
            }
            else{
                myCell1.missionImage.image = UIImage(named: "trail1.jpg")
                myCell1.imageTitle?.text = futureTitle[(indexPath as NSIndexPath).row]
                myCell1.imageDescription?.text = futureCountry[(indexPath as NSIndexPath).row]
                myCell1.distance?.text = futureTotalDistance[(indexPath as NSIndexPath).row] + " miles"
                myCell1.accessoryType = .disclosureIndicator
                myCell = myCell1
            }
            /*myCell1.missionImage.image = UIImage(named: "trail\(indexPath.row).jpg")
            myCell1.imageTitle?.text = futureTitle[indexPath.row]
            myCell1.imageDescription?.text = futureCountry[indexPath.row]
            myCell1.distance?.text = futureTotalDistance[indexPath.row]
            myCell1.accessoryType = .DisclosureIndicator
            myCell = myCell1 */
        }
        return myCell!
    }
   
    @IBAction func shareAction(_ sender: AnyObject) {
        let myShare = "Say something about this photo..."
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [myShare], applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
        
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let id = segue.identifier {
        switch(id) {
        case "inprogressRoute":
            inprogessViewController = segue.destination as? TrailViewController
            //inprogessViewController!.index = index
            inprogessViewController?.myTitle = inProgressTitle[(myTableView.indexPathForSelectedRow! as NSIndexPath).row]
            if let row = (self.myTableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                inprogessViewController!.index = row
                inprogessViewController!.trailName = inProgressTitle[row]
                inprogessViewController?.latiTdue = latitdue[row]
                inprogessViewController?.longTitude = longtitude[row]
                inprogessViewController?.nameofstation = nameofstation[row]
                inprogessViewController?.myTitle = inProgressTitle[row]
                inprogessViewController?.previousController = "Trekking"
            }
            
        case "futureRoute":
            futureViewController = segue.destination as? FutureViewController
            //futureViewController!.index = index
            futureViewController?.myTitle = futureTitle[(myTableView.indexPathForSelectedRow! as NSIndexPath).row]
            if let row = (self.myTableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                futureViewController!.index = row
                futureViewController?.latiTdue = latitdue[row]
                futureViewController?.longTitude = longtitude[row]
                futureViewController?.nameofstation = nameofstation[row]
            }
           
        default: break
            
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
