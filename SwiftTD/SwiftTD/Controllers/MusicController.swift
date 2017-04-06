//
//  MusicController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 4/6/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import Foundation
import AVFoundation

class MusicController {
    
    /// **must** define instance variable outside, because .play() will deallocate AVAudioPlayer
    /// immediately and you won't hear a thing
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "naruto", withExtension: "mp3") else {
            print("url not found")
            return
        }
        
        do {
            /// this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /// change fileTypeHint according to the type of your audio file (you can omit this)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
            
            // no need for prepareToPlay because prepareToPlay is happen automatically when calling play()
            player!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
}
