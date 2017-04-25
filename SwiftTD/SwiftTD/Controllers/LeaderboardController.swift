//
//  LeaderboardController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/18/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LeaderboardController: UITableViewController {

    var entries: [LeaderBoardEntry] = []
    var ref:FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = BACKGROUND_COLOR
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        ref = FIRDatabase.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var tableViewData: [(sectionHeader: String, entries: [LeaderBoardEntry])]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? [String : AnyObject] ?? [:]
            for key in value{
                let username = key.value["userName"] as? String ?? ""
                let score = key.value["score"] as? Int ?? -1
                self.entries.append(LeaderBoardEntry(userName: username, score: score))
            }
            
            self.sortIntoSections(entries: self.entries)
            
            //self.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func sortIntoSections(entries: [LeaderBoardEntry]) {
        
        var tmpEntries : Dictionary<String,[LeaderBoardEntry]> = [:]
        var tmpData: [(sectionHeader: String, entries: [LeaderBoardEntry])] = []
        
        // partition into sections
        for entry in entries {
            let score = entry.score!
            if var bucket = tmpEntries["\(score)"] {
                bucket.append(entry)
                tmpEntries["\(score)"] = bucket
            } else {
                tmpEntries["\(score)"] = [entry]
            }
        }
        
        // breakout into our preferred array format
        let keys = tmpEntries.keys
        for key in keys {
            if let val = tmpEntries[key] {
                tmpData.append((sectionHeader: key, entries: val))
            }
        }
        
        tmpData = tmpData.sorted {
            (s1, s2) -> Bool in return s1.sectionHeader.localizedStandardCompare(s2.sectionHeader) == .orderedDescending
        }
        
        self.tableViewData = tmpData
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let data = self.tableViewData {
            return data.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionInfo = self.tableViewData?[section] {
            return sectionInfo.entries.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FancyCell", for: indexPath) as! SwiftTDCell
        if let ll = self.tableViewData?[indexPath.section].entries[indexPath.row] {
            cell.name.text = "\(ll.userName!)"
            cell.score.text = "\(ll.score!)"
        }
        return cell
    }
}
