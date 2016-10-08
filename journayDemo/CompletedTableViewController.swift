//
//  CompletedTableViewController.swift
//  journayDemo
//
//  Created by Wang Weihan on 4/14/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit
import MapKit
class CompletedTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var photosCollectionView: UICollectionView?
    let numImages = 10
    var imageList = [String]()
    var imageList_Cinque = [String]()
    var imageList_GreatWall = [String]()
    
    var myTitle = ""
    var index = 1
    var latitdue = [44.134933,40.443088]
    var longtitude = [9.684851,116.558218]
    var nameofstation = ["stations3","stations4"]
    //var imageDes = ["Appalacian Trail","Camino de Santiago","Cinque Terre","Great Wall","Inca Trail","Appalacian Trail","Camino de Santiago","Cinque Terre","Great Wall","Inca Trail"]
    var imageDes_Cinque = ["Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre"]
    var imageDes_GreatWall = ["Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall"]
    
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var trailDescription: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = myTitle
        for index in 0...(numImages-1) {
            //imageList.append("trail\(index%5).jpg")
            imageList_Cinque.append("Cinque\(index).jpg")
            imageList_GreatWall.append("Great Wall\(index).jpg")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "com_photoCell", for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        if(index == 0){
            imageView.image = UIImage(named: imageList_Cinque[(indexPath as NSIndexPath).item])
        }else if(index == 1){
            imageView.image = UIImage(named: imageList_GreatWall[(indexPath as NSIndexPath).item])
        }
        
        //imageView.image = UIImage(named: imageList[indexPath.item])
        
        return cell
    }

    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completedCell", for: indexPath) as! CompletedTableViewCell
        cell.latiTdue = latitdue[index]
        //print(cell.latiTdue)
        cell.longTitude = longtitude[index]
        cell.nameofstation = nameofstation[index]
        cell.setLocation()
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        // Configure the cell...
         photosCollectionView = cell.photosCollectionView
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? ImageCollectionViewController {
            
            //destinationController.imageList2 = str
            
            let selectedItemsIndexPaths = photosCollectionView?.indexPathsForSelectedItems
            if(index == 0){
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_Cinque[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_Cinque[(indexPath as NSIndexPath).row]
                    }
                }
                
            }else if (index == 1){
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_GreatWall[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_GreatWall[(indexPath as NSIndexPath).row]
                    }
                }
                
            }
            /*if (selectedItemsIndexPaths!.count > 0) {
                if let indexPath = selectedItemsIndexPaths?.first {
                    destinationController.imageList2 = imageList[indexPath.row]
                    destinationController.titleImage = imageDes[indexPath.row]
                }
            }*/
            
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
