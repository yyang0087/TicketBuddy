//
//  Home.swift
//  TicketBuddy
//
//  Created by Yu-Lin Yang on 9/24/16.
//  Copyright © 2016 Yu-Lin Yang. All rights reserved.
//

import Foundation
import UIKit
public class Home: UIViewController {
    var posts = [Post]()
    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Welcome"
        //navigationController?.navigationBar.tintColor = UIColor.clear

    }
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "buy") {
            let nextScene =  segue.destination as! BuyingMenu
            nextScene.buy = true
        }
        else if(segue.identifier == "sell"){
            let nextScene =  segue.destination as! BuyingMenu
            nextScene.buy = false
        }
    }
}
