//
//  DifficultyViewController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 3/5/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit

protocol DifficultyDelegate {
    func updateDifficulty(difficulty: GameDifficulty)
}

enum GameDifficulty {
    case Easy
    case Medium
    case Hard
}

class DifficultyViewController: UIViewController {
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    var delegate:DifficultyDelegate?
    var difficulty:GameDifficulty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BACKGROUND_COLOR
        //self.delegate = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? GameViewController{
            self.delegate = dest
            self.delegate?.updateDifficulty(difficulty: difficulty)
        }
    }
    

    
    @IBAction private func easyTapped(_ sender: AnyObject) {
        difficulty = GameDifficulty.Easy
    }
    
    @IBAction private func mediumTapped(_ sender: AnyObject) {
        difficulty = GameDifficulty.Medium
    }
    
    @IBAction private func hardTapped(_ sender: AnyObject) {
        difficulty = GameDifficulty.Hard
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


