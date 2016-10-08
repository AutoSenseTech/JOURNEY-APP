//
//  Trekking2ViewController.swift
//  journayDemo
//
//  Created by Wang Weihan on 3/28/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit

class Trekking2ViewController: UIViewController {

    @IBOutlet weak var mysegment: UISegmentedControl!
    
    @IBOutlet weak var containerView1: UIView!
    
    @IBOutlet weak var containerView2: UIView!
    
    var inprogessViewController: InProgressTableViewController?
    var futureViewController:FutureViewController?
    
    //var inprogessViewController: InProgressTableViewController?
   // var futureViewController:FutureViewController?
    
    var myTitle = ""
    var index = 2;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = myTitle
        setSelectedView()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func changeSegment(sender: AnyObject) {
        setSelectedView()
    }

    
    func setSelectedView() {
        if (mysegment.selectedSegmentIndex == 0) {
            containerView1.hidden = false;
            containerView2.hidden = true;
        } else {
            containerView1.hidden = true;
            containerView2.hidden = false;
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let id = segue.identifier {
            switch(id) {
            case "inprogress":
                inprogessViewController = segue.destinationViewController as? InProgressTableViewController
                inprogessViewController!.index = index
             
                
            case "future":
                futureViewController = segue.destinationViewController as? FutureViewController
                futureViewController!.index = index
                
            default: break
                
            }
        }
        
    }

}
