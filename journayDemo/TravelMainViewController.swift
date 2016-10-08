//
//  TravelMainViewController.swift
//  journayDemo
//
//  Created by Wang Weihan on 5/5/16.
//  Copyright © 2016 Wang Weihan. All rights reserved.
//

import UIKit

class TravelMainViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var containerView1: UIView!
    
    @IBOutlet weak var containerView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView1.isHidden = false;
        containerView2.isHidden = true;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeView(_ sender: AnyObject) {
        setSelectedView()
    }
    func setSelectedView() {
        if (segmentedControl.selectedSegmentIndex == 0) {
            containerView1.isHidden = false;
            containerView2.isHidden = true;
        } else {
            containerView1.isHidden = true;
            containerView2.isHidden = false;
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
