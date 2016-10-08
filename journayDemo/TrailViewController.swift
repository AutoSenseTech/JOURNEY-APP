//
//  TrailViewController.swift
//  journayDemo
//
//  Created by MU IT Program on 5/4/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class TrailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MKMapViewDelegate{
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceCompletedAndTotal: UILabel!
    @IBOutlet weak var distanceRemainingAndTime: UILabel!
    @IBOutlet weak var trailDescription: UITextView!
   
    var numImages = 10
    var imageList = [String]()
    
    var imageDes = ["Appalacian Trail","Camino de Santiago","Cinque Terre","Great Wall","Inca Trail","Appalacian Trail","Camino de Santiago","Cinque Terre","Great Wall","Inca Trail"]
    var latitdue = [45.900203,42.939643,44.134933,40.443088,34.064379]
    var longtitude = [-68.929428,-8.680727,9.684851,116.558218,-118.567961]
    //var nameofstation = ["stations1","stations2","stations3","stations4","stations5"]
    var index = 2
    var myTitle = ""
    var trailName = ""
    var previousController = ""
    
    var imageList_App = [String]()
    var imageList_Santiago = [String]()
    var imageList_Cinque = [String]()
    var imageList_GreatWall = [String]()
    var imageList_Inca = [String]()
    
    var imageDes_App = ["Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail","Appalacain Trail"]
    var imageDes_Santiago = ["Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago","Camino de Santiago"]
    var imageDes_Cinque = ["Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre","Cinque Terre"]
    var imageDes_GreatWall = ["Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall","Great Wall"]
    var imageDes_Inca = ["Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail","Inca Trail"]
    
    var latiTdue  =  44.134933//[38.932879,42.878742,44.134933,40.429225,34.008033]
    var longTitude = 9.684851//[-78.0300279,-8.548143,9.684851,116.564898,-118.420708]
    var nameofstation = "stations3"
    
    var trails: [NSManagedObject]?
    
    var timeSpent = 0
    var completedMiles = 0
    var totalLength = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = MKMapType.hybrid
        self.title = myTitle
        for index in 0...(numImages-1) {
            //imageList.append("trail\(index%5).jpg")
            imageList_App.append("Appalachian\(index).jpg")
            imageList_Santiago.append("Santiago\(index).jpg")
            imageList_Cinque.append("Cinque\(index).jpg")
            imageList_GreatWall.append("Great Wall\(index).jpg")
            imageList_Inca.append("Inca\(index).jpg")
            
            trails = SetupCoreData.loadTrails()
            for trail in trails! {
                if(previousController == "Trekking"){
                    if trail.value(forKey: "trailName")! as! String == trailName {
                        completedMiles = trail.value(forKey: "totalMiles") as! NSInteger
                        distanceCompletedAndTotal.text = "Distance Completed: " + completedMiles.description + " miles"
                    }
                }
                else{
                    if trail.value(forKey: "trailName")! as! String == trailName {
                        timeSpent = trail.value(forKey: "timeSpent") as! NSInteger
                        distanceRemainingAndTime.text = "Total Time: " + timeSpent.description + " days"
                    }
                }
                
            }
            let path = Bundle.main.path(forResource: "Trails", ofType: "plist")
            let trailsPlist = NSDictionary(contentsOfFile: path!)
            if let items = trailsPlist?.allValues {
                for item in items {
                    if let theItem = item as? NSDictionary {
                        if theItem.value(forKey: "name") as! String == myTitle {
                            trailDescription.text = theItem.value(forKey: "description") as! String
                            totalLength = Int(theItem.value(forKey: "lengthmiles") as! NSNumber)
                        }
                    }
                }
            }
        }
        
        if(previousController == "Trekking"){
            distanceRemainingAndTime.text = "Distance Remaining: " + (totalLength-completedMiles).description + " miles"
            numImages = 5
        }
        else{
            distanceCompletedAndTotal.text = "Total Distance: " + totalLength.description + " miles"
            numImages = 10
        }
        
        zoomToRegion()
        
        let annotations = getMapAnnotations()
        
        // Add mappoints to Map
        mapView.addAnnotations(annotations)
        
        mapView.delegate = self
        
        // Connect all the mappoints using Poly line.
        
        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        
        for annotation in annotations {
            points.append(annotation.coordinate)
        }
        
        
        let polyline = MKPolyline(coordinates: &points, count: points.count)
        
        mapView.add(polyline)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(previousController != "Trekking"){
            /*var insertIndexPath = NSIndexPath(forItem: 5, inSection: 0)
            photosCollectionView.insertItemsAtIndexPaths([insertIndexPath])
            */
            /*Int indexPath = [NSIndexPath indexPathForItem:5]
            NSArray *indexPaths = [NSArray arrayWithObject:indexPath inSection:0]
            [collectionView insertItemsAtIndexPaths:indexPaths]*/
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(previousController == "Trekking") {
            return 5
        }
        else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photocell", for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        if(self.title == "Appalachian Trail"){
            imageView.image = UIImage(named: imageList_App[(indexPath as NSIndexPath).item])
        }else if(self.title == "Camino de Santiago"){
            imageView.image = UIImage(named: imageList_Santiago[(indexPath as NSIndexPath).item])
        }else if(self.title == "Cinque Terre"){
            imageView.image = UIImage(named: imageList_Cinque[(indexPath as NSIndexPath).item])
        }else if(self.title == "Great Wall"){
            imageView.image = UIImage(named: imageList_GreatWall[(indexPath as NSIndexPath).item])
        }else{
            imageView.image = UIImage(named: imageList_Inca[(indexPath as NSIndexPath).item])
        }
        
        
        return cell
    }
    
    func zoomToRegion() {
        
        var zoomLat: Double
        var zoomLong: Double
        
        if(self.title == "Great Wall"){
           latiTdue = 40.444166
            longTitude = 116.556744
            zoomLat = 1000
            zoomLong = 2000
        }
        else{
            latiTdue = 45.898299
            longTitude = -68.936942
            zoomLat = 1000.0
            zoomLong = 2000.0
            
        }
        //great wall : 40.4319 , 116.5704
        
        //appalachian trail 38.9167 , 78.0495
        
        let location = CLLocationCoordinate2D(latitude: latiTdue, longitude: longTitude)
        
        let region = MKCoordinateRegionMakeWithDistance(location, zoomLat, zoomLong)
        
        mapView.setRegion(region, animated: true)
    }
    
    //MARK:- Annotations
    
    func getMapAnnotations() -> [Station] {
        var annotations:Array = [Station]()
        
        //load plist file
        
        if(self.title == "Great Wall"){
            nameofstation = "stations4"
        }
        else{
            nameofstation = "stations1"
        }
        
        var stations: NSArray?
        if let path = Bundle.main.path(forResource: nameofstation, ofType: "plist") {
            stations = NSArray(contentsOfFile: path)
        }
        if let items = stations {
            for item in items {
                let lat = (item as AnyObject).value(forKey: "lat") as! Double
                let long = (item as AnyObject).value(forKey: "long")as! Double
                let annotation = Station(latitude: lat, longitude: long)
                annotation.title = (item as AnyObject).value(forKey: "title") as? String
                annotations.append(annotation)
            }
        }
        
        return annotations
    }
    
    //MARK:- MapViewDelegate methods
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        if overlay is MKPolyline {
            polylineRenderer.strokeColor = UIColor.red
            polylineRenderer.lineWidth = 2
            
        }
        return polylineRenderer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationController = segue.destination as? ImageCollectionViewController {
            let selectedItemsIndexPaths = photosCollectionView?.indexPathsForSelectedItems
            if(self.title == "Appalachian Trail"){
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_App[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_App[(indexPath as NSIndexPath).row]
                        destinationController.trailName = "Appalachian Trail"
                    }
                }
            } else if(self.title == "Camino de Santiago"){
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_Santiago[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_Santiago[(indexPath as NSIndexPath).row]
                        destinationController.trailName = "Camino de Santiago"
                    }
                }
            }else if(self.title == "Cinque Terre"){
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_Cinque[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_Cinque[(indexPath as NSIndexPath).row]
                        destinationController.trailName = "Cinque Terre"
                    }
                }
            }else if(self.title == "Great Wall"){
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_GreatWall[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_GreatWall[(indexPath as NSIndexPath).row]
                        destinationController.trailName = "Great Wall"
                    }
                }
            }else{
                if (selectedItemsIndexPaths!.count > 0) {
                    if let indexPath = selectedItemsIndexPaths?.first {
                        destinationController.imageList2 = imageList_Inca[(indexPath as NSIndexPath).row]
                        destinationController.titleImage = imageDes_Inca[(indexPath as NSIndexPath).row]
                        destinationController.trailName = "Inca Trail"
                    }
                }
            }
            let factIndexPath = selectedItemsIndexPaths?.first
            destinationController.indexFact = (factIndexPath! as NSIndexPath).row
        }
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
