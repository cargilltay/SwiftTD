//
//  FireBaseController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/17/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FireBaseController {
    
    var ref:FIRDatabaseReference!
    var entries: [LeaderBoardEntry]!
    
    init(){
        ref = FIRDatabase.database().reference()
        self.registerForFireBaseUpdates()
    }
    
    func addLeaderboardEntry(entry: LeaderBoardEntry){
        let newChild = self.ref?.child("users").childByAutoId()
        newChild?.setValue(self.toDictionary(vals: entry))
    }
    
    func toDictionary(vals: LeaderBoardEntry) -> NSDictionary {
        return [
            "userName": NSString(string: vals.userName!),
            "score" : NSNumber(value: vals.score!),
        ]
    }
    
    fileprivate func registerForFireBaseUpdates()
    {
        self.ref!.child("history").observe(.value, with: { snapshot in
            if let postDict = snapshot.value as? [String : AnyObject] {
                var tmpItems = [LeaderBoardEntry]()
                for (_,val) in postDict.enumerated() {
                    let entry = val.1 as! Dictionary<String,AnyObject>
                    let userName = entry["userName"] as! String?
                    let score = entry["score"] as! Int?
                    tmpItems.append(LeaderBoardEntry(userName: userName!,
                                                   score: score!))
                }
                self.entries = tmpItems
            }
        })
        
    }
}
