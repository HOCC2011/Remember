//
//  LiveActivityManager.swift
//  Remember
//
//  Created by HOCC on 12/13/25.
//


import Foundation
import ActivityKit
import SwiftUI

@Observable
class LiveActivityManager {
    private var liveActivity: Activity<TaskWidgetAttributes>?
    
    var isLiveActivityActive: Bool {
        liveActivity != nil
    }
    
    // MARK: - Live Activity Management
    
    func startLiveActivity(taskString: String, taskNumber: Int) {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Live Activities are not enabled")
            return
        }
        
        // End any existing activity first
        endLiveActivity()
        
        let attributes = TaskWidgetAttributes(name: "Remember")
        let contentState = TaskWidgetAttributes.ContentState(
            taskString: taskString,
            taskNumber: taskNumber
        )
        
        do {
            liveActivity = try Activity<TaskWidgetAttributes>.request(
                attributes: attributes,
                content: ActivityContent(state: contentState, staleDate: nil),
                pushType: nil
            )
            print("Live Activity started successfully")
        } catch {
            print("Error starting live activity: \(error)")
        }
    }
    
    func updateLiveActivity(taskString: String, taskNumber: Int) {
        guard let liveActivity = liveActivity else { return }
        
        Task {
            let contentState = TaskWidgetAttributes.ContentState(
                taskString: taskString,
                taskNumber: taskNumber
            )
            
            await liveActivity.update(ActivityContent(state: contentState, staleDate: nil))
            print("Live Activity updated")
        }
    }
    
    func endLiveActivity() {
        guard let liveActivity = liveActivity else { return }
        
        Task {
            await liveActivity.end(nil, dismissalPolicy: .immediate)
            self.liveActivity = nil
            print("Live Activity ended")
        }
    }

}
