//
//  GameOverModal.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/17/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation
import UIKit

class GameOverModal: UIViewController {
    
    override func viewDidLoad() {
        
        //self.view.backgroundColor = BACKGROUND_COLOR
        
        
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        
        self.view.insertSubview(blurEffectView, at: 0)
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
    }
}
