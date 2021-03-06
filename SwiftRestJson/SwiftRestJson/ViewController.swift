//
//  ViewController.swift
//  SwiftRestJson
//
//  Created by Enkhjargal Gansukh on 1/22/16.
//  Copyright © 2016 Enkhjargal Gansukh. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class tableViewController: UITableViewController{

    var listItems = [String]()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        activityIndicator.startAnimating()
        fromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        let item = listItems[indexPath.row]
        cell.textLabel?.text = item
        
        return cell
    }
    
    func fromServer(){
        Alamofire.request(.GET, "http://jsonplaceholder.typicode.com/posts")
            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result.value!)   // result of response serialization
                
                if let resJSON = response.result.value {
                    self.parseJSON(resJSON)
//                    let json = JSON(resJSON)
//                    print(json)
                }
        }
    }
    

    func parseJSON(temp_data:AnyObject){
        listItems = [String]()
        let json = JSON(temp_data)
//        print(json)
        for (index,subJson):(String, JSON) in json {
                print(subJson["title"])
//                let title = subJson["title"] as! String
                listItems.append("\(subJson["title"])")
        }
        self.tableView.reloadData()
        activityIndicator.stopAnimating()
    }
}

