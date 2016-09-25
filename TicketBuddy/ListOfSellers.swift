//
//  ListOfSellers.swift
//  TicketBuddy
//
//  Created by Yu-Lin Yang on 9/24/16.
//  Copyright © 2016 Yu-Lin Yang. All rights reserved.
//

import UIKit
class ListOfSellers: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var buy = false
    var posts = [[String: AnyObject]]()
    var thisGame = ""
    
    // Data model: These strings will be the data for the table view cells
    var animals: [String] = ["Bob", "Billy", "Billy-Bob", "Dylan", "Rufus"]
    var prices: [String] = ["$4", "$5", "$9", "$3", "$1"]
    //var animals: [String] = []
    //var prices: [String] = []
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(buy) {
            navigationItem.title = "Buying"
            //***REQUEST BUYING LIST OF JSON***
            posts = Post.downloadList(type: "buyingList") as! [[String : AnyObject]]
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Request", style: .plain, target: self, action: #selector(addTapped))
        }
        else {
            navigationItem.title = "Selling"
            //***REQUEST SELLING LIST OF JSON***
            posts = Post.downloadList(type: "sellingList") as! [[String : AnyObject]]
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post Ticket", style: .plain, target: self, action: #selector(addTapped))
        }

        print("this game is tis fsj \(thisGame)")
        navigationItem.title = thisGame
        print(posts.count)
        for (index,post) in posts.enumerated(){
            print("post number \(post)")
            //print(post[""]!)
            print(index)
            let isIndexValid = animals.indices.contains(index)
            print(isIndexValid)
            animals[index] = post["author"]! as! String
            prices[index] = post["price"] as! String
        }
        
        

        
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    func addTapped() {
        var amount = ""
        var alert = UIAlertController(title: "New Offer", message: "How much are you willing to pay?", preferredStyle: .alert)
        if(!buy) {
            alert = UIAlertController(title: "List Ticket", message: "What's your asking price?", preferredStyle: .alert)
        }
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "For e.g. $400"
            textField.keyboardType = UIKeyboardType.numberPad
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            _ = alert.textFields![0] as UITextField
        }))
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            amount = textField.text!
            self.reqMade()
            //***append the new entry here***
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    func reqMade(){
        let alert = UIAlertController(title: "Notice", message: "Your request has been made.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Request", style: .default, handler: { action in print() }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        if(buy) {
            cell.textLabel?.text = "\(self.animals[indexPath.row]) is asking for $\(self.prices[indexPath.row])"
        }
        else {
            cell.textLabel?.text = "\(self.animals[indexPath.row]) is willing to pay $\(self.prices[indexPath.row]) for a ticket"
        }
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ didSelectRowAttableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var alert = UIAlertController(title: "New Offer", message: "\(self.animals[indexPath.row]) is willing to pay $\(self.prices[indexPath.row]). What's your offer?", preferredStyle: .alert)
        if(buy) {
            alert = UIAlertController(title: "New Offer", message: "\(self.animals[indexPath.row]) is asking for $\(self.prices[indexPath.row]). What's your offer?", preferredStyle: .alert)
        }
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "For e.g. $40"
            textField.keyboardType = UIKeyboardType.numberPad
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            _ = alert.textFields![0] as UITextField
        }))
        alert.addAction(UIAlertAction(title: "Send Offer", style: .default, handler: { action in self.sendOffer() }))
        self.present(alert, animated: true, completion: nil)
    }
    func sendOffer() {
        for id in posts {
            
        }
    }
}
