//
//  EntryProtocols.swift
//  TicketBuddy
//
//  Created by Yu-Lin Yang on 9/24/16.
//  Copyright © 2016 Yu-Lin Yang. All rights reserved.
//

import Foundation
import UIKit

protocol listOfEntries {
    //func adjustDate(_ dateToggle: Bool)
    //func adjustTimer(_ timerSelection: Int)
    //func adjustBackground(_ backgroundColor: UIImage)
    static var idCounter: Int { get set }
    static var emailList: Array<String> {get set}
}
