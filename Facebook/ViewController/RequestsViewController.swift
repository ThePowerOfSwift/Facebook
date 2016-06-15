//
//  RequestsViewController.swift
//  Facebook
//
//  Created by Mihail Șalari on 6/14/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class RequestsViewController: UITableViewController {
    
    // MARK: - Properties
    
    
    // MARK: - LyfeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupUI() {
        self.navigationItem.title = "Friend Requests"
        self.tableView.separatorColor = UIColor.tableviewSeparatorFeatureColor()
        self.tableView.sectionHeaderHeight = 26
        
        self.tableView.registerClass(RequestTabeViewCell.self, forCellReuseIdentifier: Constants.Storyboard.RequestCellID)
        self.tableView.registerClass(RequestHeaderCell.self, forHeaderFooterViewReuseIdentifier: Constants.Storyboard.RequestHeaderCellID)
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let requestCell = tableView.dequeueReusableCellWithIdentifier(Constants.Storyboard.RequestCellID) as! RequestTabeViewCell
        
        requestCell.userInteractionEnabled = false
        
        if indexPath.row % 3 == 0 {
            requestCell.nameLabel.text = "Bill Graham"
            requestCell.requestImageView.image = UIImage(named: "bill_profile")
        } else if indexPath.row % 3 == 1 {
            requestCell.nameLabel.text = "Eddy Cue"
            requestCell.requestImageView.image = UIImage(named: "eddy_profile")
        } else {
            requestCell.nameLabel.text = "Bill Graham"
            requestCell.requestImageView.image = UIImage(named: "bill_profile")
        }
        
        requestCell.imageView?.backgroundColor = UIColor.blackColor()
        
        return requestCell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterViewWithIdentifier(Constants.Storyboard.RequestHeaderCellID) as! RequestHeaderCell
        
        if section == 0 {
            headerCell.nameLabel.text = "friend requests".uppercaseString
        } else {
            headerCell.nameLabel.text = "people you may know".uppercaseString
        }
        
        return headerCell
    }
    
}
