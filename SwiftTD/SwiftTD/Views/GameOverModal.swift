//
//  GameOverModal.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/17/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation
import UIKit
import Social

class GameOverModal: UIViewController {
    
    @IBAction func showShareOptions(_ sender: Any) {
        //need to dismiss the popover
        
        let actionSheet = UIAlertController(title: "", message: "Share your Note", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
            // Configure a new action for sharing the note in Twitter.
        let tweetAction = UIAlertAction(title: "Share on Twitter", style: UIAlertActionStyle.default) { (action) -> Void in
            // Check if sharing to Twitter is possible.
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                // Initialize the default view controller for sharing the post.
                let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                
                // Set the score as the default post message.
                twitterComposeVC?.setInitialText("HELLO WORLD")
                    
                self.present(twitterComposeVC!, animated: true, completion: nil)
            }
            else {
                self.showAlertMessage(message: "You are not logged in to your Twitter account.")
            }
        }
        
        
        // Configure a new action to share on Facebook.
        let facebookPostAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.default) { (action) -> Void in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                facebookComposeVC?.setInitialText("HELLO WORLD")
                
                self.present(facebookComposeVC!, animated: true, completion: nil)
            }
            else {
                self.showAlertMessage(message: "You are not connected to your Facebook account.")
            }
        }
        
        // Configure a new action to show the UIActivityViewController
        let moreAction = UIAlertAction(title: "More", style: UIAlertActionStyle.default) { (action) -> Void in
            let activityViewController = UIActivityViewController(activityItems: ["HELLO WORLD"], applicationActivities: nil)
            
            activityViewController.excludedActivityTypes = [UIActivityType.mail]
            
            self.present(activityViewController, animated: true, completion: nil)

        }
        
        
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (action) -> Void in
            
        }
        
        
        actionSheet.addAction(tweetAction)
        actionSheet.addAction(facebookPostAction)
        actionSheet.addAction(moreAction)
        actionSheet.addAction(dismissAction)
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "EasyShare", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
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
