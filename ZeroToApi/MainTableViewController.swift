//
//  MainTableViewController.swift
//  ZeroToApi
//
//  Created by Madison, Jon on 9/8/15.
//  Copyright (c) 2015 Madison, Jon. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var selectedPlantId:Int = Int()
    var plants:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postEndpoint: String = "https://ftapi-ex.herokuapp.com/v1/plants"
//      let postEndpoint: String = "http://localhost:3000/v1/plants"
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        if let url = NSURL(string:postEndpoint) {
            NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler:{
                (data:NSData?, response:NSURLResponse?, err:NSError?) -> Void in
                if let anError = err
                {
                    print("error calling GET on /plants")
                    print(anError)
                }
                else
                {
                    do
                    {
                        let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.plants = result["plants"] as! NSArray
                            self.tableView.reloadData()
                        })
                    } catch let aJSONError as NSError {
                        print("error parsing /plants")
                        print(aJSONError)
                    }
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                })
            }).resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.plants.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 

        let plant:NSDictionary = plants[indexPath.row] as! NSDictionary
        
        if let name = plant["name"] as? String {
            cell.textLabel?.text = name
        }
        
        if let duration = plant["duration"] as? String {
            cell.detailTextLabel?.text = duration
        }
        
        return cell
    }

    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let plant:NSDictionary = plants[indexPath.row] as! NSDictionary
        
        selectedPlantId = plant["id"] as! Int
        performSegueWithIdentifier("plantDetail", sender: self)
        
        return indexPath
    }
    
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc:PlantDetailViewController = segue.destinationViewController as? PlantDetailViewController {
            vc.plantId = selectedPlantId
        }
    }
}
