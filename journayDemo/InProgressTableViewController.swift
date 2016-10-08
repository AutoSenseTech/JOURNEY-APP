//
//  InProgressTableViewController.swift
//  journayDemo
//
//  Created by Wang Weihan on 4/6/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit
import MapKit

class InProgressTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
   
    var photosCollectionView: UICollectionView?
    let numImages = 10
    var imageList = [String]()
    var str = ""
    var imageDes = ["Appalacian Trail","Camino de Santiago","Cinque Terre","Great Wall","Inca Trail","Appalacian Trail","Camino de Santiago","Cinque Terre","Great Wall","Inca Trail"]
    var latitdue = [45.900203,42.939643,44.134933,40.443088,34.064379]
    var longtitude = [-68.929428,-8.680727,9.684851,116.558218,-118.567961]
    var nameofstation = ["stations1","stations2","stations3","stations4","stations5"]
    var index = 2
    var myTitle = ""
    
    var imageList_App = [String]()
    var imageList_Santiago = [String]()
    var imageList_Cinque = [String]()
    var imageList_GreatWall = [String]()
    var imageList_Inca = [String]()
    
    @IBOutlet weak var distanceCompleted: UILabel!
    @IBOutlet weak var distanceRemaining: UILabel!
    @IBOutlet weak var trailDescription: UITextView!
    
    var imageDes_App = ["Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail"]
    var imageDes_Santiago = ["Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago"]
    var imageDes_Cinque = ["Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre"]
    var imageDes_GreatWall = ["Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall"]
    var imageDes_Inca = ["Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = myTitle
        for index in 0...(numImages-1) {
            imageList.append("trail\(index%5).jpg")
            imageList_App.append("Appalachian\(index).jpg")
            imageList_Santiago.append("Santiago\(index).jpg")
            imageList_Cinque.append("Cinque\(index).jpg")
            imageList_GreatWall.append("Great Wall\(index).jpg")
            imageList_Inca.append("Inca\(index).jpg")
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //FOR connection cell
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photocell", for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        if(index == 0){
            imageView.image = UIImage(named: imageList_App[(indexPath as NSIndexPath).item])
        }else if(index == 1){
            imageView.image = UIImage(named: imageList_Santiago[(indexPath as NSIndexPath).item])
        
        }else if(index == 2){
            imageView.image = UIImage(named: imageList_Cinque[(indexPath as NSIndexPath).item])
        }else if(index == 3){
            imageView.image = UIImage(named: imageList_GreatWall[(indexPath as NSIndexPath).item])
        }else{
            imageView.image = UIImage(named: imageList_Inca[(indexPath as NSIndexPath).item])
        }
        
        return cell
    }

    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let incell = tableView.dequeueReusableCell(withIdentifier: "inprogress_cell", for: indexPath) as! MapViewTableViewCell
        incell.latiTdue = latitdue[index]    //index]
        
     
        incell.longTitude = longtitude[index]
        incell.nameofstation = nameofstation[index]
        incell.setLocation()
        //print("set longtitude")
        //incell.latiTdue = latitdue[index]
        
        incell.selectionStyle = UITableViewCellSelectionStyle.none
        
        photosCollectionView = incell.photosCollectionView

        return incell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? ImageCollectionViewController {
             let selectedItemsIndexPaths = photosCollectionView?.indexPathsForSelectedItems
            if(index == 0){
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_App[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_App[(indexPath as NSIndexPath).row]
                    }
                }
            } else if(index == 1){
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_Santiago[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_Santiago[(indexPath as NSIndexPath).row]
                    }
                }
            }else if(index == 2){
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_Cinque[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_Cinque[(indexPath as NSIndexPath).row]
                    }
                }
            }else if(index == 3){
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_GreatWall[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_GreatWall[(indexPath as NSIndexPath).row]
                    }
                }
            }else{
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_Inca[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_Inca[(indexPath as NSIndexPath).row]
                    }
                }
            }
            /*let selectedItemsIndexPaths = photosCollectionView?.indexPathsForSelectedItems()
            
            if (selectedItemsIndexPaths!.count > 0) {
                if let indexPath = selectedItemsIndexPaths?.first {
                    destinationController.imageList2 = imageList[indexPath.row]
                    destinationController.titleImage = imageDes[indexPath.row]
                }
            }*/
        }
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    /*
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        str = imageList[indexPath.item]
        
    }
 */
    
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
