//
//  BuyingMenu.swift
//  TicketBuddy
//
//  Created by Yu-Lin Yang on 9/24/16.
//  Copyright © 2016 Yu-Lin Yang. All rights reserved.
//

import UIKit
class BuyingMenu: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var thisGame = ""
    // Data model: These strings will be the data for the table view cells
    var animals: [String] = ["9/10 vs. Akron Zips", "9/17 vs. Georgia State Panthers", "10/15 vs. Ohio State Buckeyes", "10/29 vs. Nebraska Cornhuskers", "11/12 vs. Illinois Fighting Illini","11/17 vs. Chicago State","11/27 vs. Prairie View A&M", "11/29 vs. Syracuse","12/3 vs Oklahoma", "12/7 vs. Idaho State", "12/14 vs. Green Bay","12/23 vs. Florida A&M","12/27 vs. Rutgers","1/12 vs. Ohio State","1/17 vs. Michigan"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    var buy = false
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(buy) {
            navigationItem.title = "Buying"
            navigationController?.navigationBar.barTintColor = UIColor(red:1.00, green:0.35, blue:0.16, alpha:1.0)
            //navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            //navigationController?.navigationBar.shadowImage = UIImage()
            //navigationController?.navigationBar.isTranslucent = true
            //***REQUEST BUYING LIST OF JSON***
            //posts = Post.downloadList(type: "buyingList") as! [[String : AnyObject]]
        }
        else {
            navigationItem.title = "Selling"
            navigationController?.navigationBar.barTintColor = UIColor(red:0.74, green:1.00, blue:0.34, alpha:1.0)
            //***REQUEST SELLING LIST OF JSON***
            //posts = Post.downloadList(type: "sellingList") as! [[String : AnyObject]]
        }
        
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScene =  segue.destination as! ListOfSellers
        nextScene.buy = buy
        nextScene.thisGame = thisGame
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        print("hihihihihihihihi hihih ih i--------------------------------------------")
        navigationController?.navigationBar.barTintColor = nil;
        
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.animals[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ didSelectRowAttableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        thisGame = self.animals[indexPath.row]
        performSegue(withIdentifier: "toListOfSellers", sender: indexPath.row)
    }
}
