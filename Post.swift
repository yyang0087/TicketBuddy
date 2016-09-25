//
//  Post.swift
//  TicketBuddy
//
//  Created by Yu-Lin Yang on 9/24/16.
//  Copyright © 2016 Yu-Lin Yang. All rights reserved.
//

import Foundation
//the object post is the dictionary in the list of entries
class Post
{
    //var buyPosts =
    
    var email: String?
    var idOfPost: String?
    var eventDate: String?
    var author: String?
    var price: String?
    
    init(email: String, idOfPost: String, eventDate: String, author: String, price: String)
    {
        self.email = email
        self.idOfPost = idOfPost
        self.eventDate = eventDate
        self.author = author
        self.price = price
    }
    
    init(espDictionary: [String : AnyObject])
    {
        self.email = espDictionary["email"] as? String
        self.idOfPost = espDictionary["idOfPost"] as? String
        self.eventDate = espDictionary["eventDate"] as? String
        self.author = espDictionary["author"] as? String
        self.price = espDictionary["price"] as? String

    }

    //Pass in buyingList or sellingList
    static func downloadList(type:String) -> Array<Any>
    {
        var dictionaries = [[String: AnyObject]]()
        
        let jsonFile = Bundle.main.path(forResource: "TicketBuddy", ofType: "json")
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!))
        if let jsonDictionary = NetworkService.parseJSONFromData(jsonData){
            print("json:     \(jsonDictionary)")
            let espDictionaries = jsonDictionary[type] as! [[String : AnyObject]]
            print("espdictionaries:     \(espDictionaries)")
            for espDictionary in espDictionaries {
                print("espdictionary:     \(espDictionary)")
                let newEpisode = Post(espDictionary: espDictionary)
                print("newepisode:     \(newEpisode)")
                dictionaries.append(espDictionary)
            }
        }
        
        return dictionaries
    }
    static func uploadList() {
        
        
        
        //let json = [ Activity.KEY_IDSUBJECT : activity.idSubject, Activity.KEY_RECORDMODE : "3", Activity.KEY_LOCATION_LONGITUDE : "0",Activity.KEY_LOCATION_LATITUDE : "0", Activity.KEY_CHECKIN : String(activity.dateCheckIn), Activity.KEY_CHECKOUT : String(activity.dateCheckOut) ]
        
        
        do {
            //let dic = ["2": "B", "1": "A", "3": "C"]
            let dic = [
                "email": "5@5.com",
                "idOfPost": "5",
                "eventDate": "2015-04-23T18:25:43.511Z",
                "author": "echo",
                "price": "5"
            ]
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            //let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!))
            // create post request
            let url = NSURL(string: "http://128.61.57.162:8080/api/newSeller")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    return
                }
                
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                    
                    print("Result -> \(result)")
                    //print("Response -> \(response)")
                    
                } catch {
                    print("Error -> \(error)")
                }
            }
            
            task.resume()
            
            
            
        } catch {
            print(error)
        }
    
        
    }
    
    
    
}
