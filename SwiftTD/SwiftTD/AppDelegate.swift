//
//  AppDelegate.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 2/24/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit
import Firebase

let BACKGROUND_COLOR = hexStringToUIColor(hex: "#00796B")

let FOREGROUND_COLOR = UIColor.init(colorLiteralRed: 0.937, green: 0.820, blue:0.576, alpha: 1.0);

let THEME_COLOR1 = UIColor.init(colorLiteralRed:0.000, green:0.157, blue:0.216,
                                alpha:1.00)  // DARK BLUE
let THEME_COLOR2 = UIColor.init(colorLiteralRed:0.000, green:0.369, blue:0.420,
                                alpha:1.00) // Light Tan
let THEME_COLOR3 = UIColor.init(colorLiteralRed: 0.937, green: 0.820, blue: 0.576,
                                alpha: 1.0)  // Lighter Blue
let THEME_COLOR4 = UIColor.init(colorLiteralRed:0.576, green:0.596, blue:0.329,
                                alpha:1.00) // Greenish Tan
let THEME_COLOR5 = UIColor.init(colorLiteralRed:0.251, green:0.286, blue:0.141,
                                alpha:1.00) // Army Green

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if(url .host! == "page"){
            if(url .path == "/page1"){
                self.window?.rootViewController = SignUpViewController()
                self.window?.makeKeyAndVisible()
                //[self.mainController pushViewController:[[Page1ViewController alloc] init] animated:YES];
            //}
            }
        }
            return true;

    }


}

