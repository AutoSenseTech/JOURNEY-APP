//
//  CompletedTableViewCell.swift
//  journayDemo
//
//  Created by Wang Weihan on 4/14/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit
import MapKit
class CompletedTableViewCell: UITableViewCell, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var latiTdue  =  40.429225//[38.932879,42.878742,44.134933,40.429225,34.008033]
    var longTitude = 116.564898//[-78.0300279,-8.548143,9.684851,116.564898,-118.420708]
    var nameofstation = "stations4" //["stations1","stations2","stations3","stations4","stations5"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.mapType = MKMapType.hybrid

    }
    func setLocation(){
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
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: latiTdue, longitude: longTitude)
        
        let region = MKCoordinateRegionMakeWithDistance(location, 5000.0, 7000.0)
        
        mapView.setRegion(region, animated: true)
    }
    
    //MARK:- Annotations
    
    func getMapAnnotations() -> [Station] {
        var annotations:Array = [Station]()
        
        //load plist file
        
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
    
}
