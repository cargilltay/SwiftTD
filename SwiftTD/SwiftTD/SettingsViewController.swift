//
//  SettingsViewController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 3/5/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var soundEffectsSlider: UISlider!
    @IBOutlet weak var musicSlider: UILabel!
    @IBOutlet weak var confirmButton: SwiftTDButton!
   
    @IBAction func confirmButtonAction(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BACKGROUND_COLOR

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
