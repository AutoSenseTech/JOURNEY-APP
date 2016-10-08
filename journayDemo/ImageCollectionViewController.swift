//
//  ImageCollectionViewController.swift
//  journayDemo
//
//  Created by Wang Weihan on 4/7/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UIViewController {

    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var imageDescription: UITextView!

    
    var imageList2 = ""
    
    var titleImage = ""
    
    var indexFact = 0
    
    var trailName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var listName = ""
        if(trailName == "Great Wall"){
            listName = "GreatWallFacts"
        }
        else{
            listName = "AppalichianTrailFacts"
        }

        let path = Bundle.main.path(forResource: listName, ofType: "plist")
        let trailsPlist = NSDictionary(contentsOfFile: path!)
        imageDescription.text = trailsPlist!.value(forKey: String(indexFact)) as! String

       /* let path = NSBundle.mainBundle().pathForResource("Trails", ofType: "plist")
        let trailsPlist = NSDictionary(contentsOfFile: path!)
        if let items = trailsPlist?.allValues {
            for item in items {
                if let theItem = item as? NSDictionary {
                    if theItem.valueForKey("name") as! String == myTitle {
                        trailDescription.text = theItem.valueForKey("description") as! String
                        totalLength = Int(theItem.valueForKey("lengthmiles") as! NSNumber)
                    }
                }
            }
        }*/

        selectedImage.image = UIImage(named: imageList2)
        
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
