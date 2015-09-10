//
//  PlantDetailViewController.swift
//  ZeroToApi
//
//  Created by Madison, Jon on 9/9/15.
//  Copyright (c) 2015 Madison, Jon. All rights reserved.
//

import UIKit

class PlantDetailViewController: UIViewController {
    var plantId = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var postEndpoint: String = "https://ftapi-ex.herokuapp.com/v1/plants"
        //        var postEndpoint: String = "http://localhost:3000/v1/plants"
        let requestString = "\(postEndpoint)/\(plantId)"
        var urlRequest = NSURLRequest(URL: NSURL(string: requestString)!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
        
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
