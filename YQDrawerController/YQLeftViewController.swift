//
//  YQLeftViewController.swift
//  YQDrawerController
//
//  Created by 杨雯德 on 15/11/5.
//  Copyright © 2015年 杨雯德. All rights reserved.
//

import UIKit

class YQLeftViewController: UITableViewController,YQDrawerDelegate {

    
    var sSdrawer:YQDrawerViewController!
    var colors = [ UIColor(red: 237.0/255.0, green: 195.0/255.0, blue: 0.0/255.0, alpha: 1.0),
                        UIColor(red: 237.0/255.0, green: 147.0/255.0, blue: 0.0/255.0, alpha: 1.0),
                        UIColor(red: 237.0/255.0, green: 9.0/255.0, blue: 0.0/255.0, alpha: 1.0)
                      ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func gameDidStart(game: YQDrawerViewController){
        self.sSdrawer = game
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "friendcell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }

        if indexPath.row == 0{
            cell!.backgroundColor = self.colors[0]
        }else if indexPath.row == 1{
            cell!.backgroundColor = self.colors[1]

        }else if indexPath.row == 2{
            cell!.backgroundColor = self.colors[2]
        }
        
        return cell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.sSdrawer.close()
        
        self.sSdrawer.reloadCenterViewController { (color:UIColor) -> Void in
            
        }
    }

    
}
