//
//  StopWatchManager.swift
//  Messangel
//
//  Created by Saad on 6/21/21.
//

import SwiftUI

enum stopWatchMode {
    case running
    case stopped
    case paused
}

class StopWatchManager: ObservableObject {
    
    @Published var stopWatchTime = "00:00:00"
    @Published var mode: stopWatchMode = .stopped
    private var timer = Timer()
    private var counter: Int = 0
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.counter += 1
            self.stopWatchTime = StopWatchManager.convertCountToTimeString(counter: self.counter)
        }
    }
    
//    func pause() {
//        timer.invalidate()
//        mode = .paused
//    }
    
    func stop() {
        timer.invalidate()
        stopWatchTime = "00:00:00"
        mode = .stopped
    }
    
    static func convertCountToTimeString(counter: Int) -> String {
        let millseconds = counter % 100
        let seconds = counter / 100
        let minutes = seconds / 60
        
        var millsecondsString = "\(millseconds)"
        var secondsString = "\(seconds)"
        var minutesString = "\(minutes)"
        
        if millseconds < 10 {
            millsecondsString = "0" + millsecondsString
        }
        
        if seconds < 10 {
            secondsString = "0" + secondsString
        }
        
        if minutes < 10 {
            minutesString = "0" + minutesString
        }
        
        return "\(minutesString):\(secondsString):\(millsecondsString)"
    }
}
