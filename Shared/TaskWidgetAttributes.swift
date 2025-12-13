//
//  TaskWidgetAttributes.swift
//  Remember
//
//  Created by HOCC on 12/13/25.
//

import Foundation
import ActivityKit

// MARK: - Attributes Definition

public struct TaskWidgetAttributes: ActivityAttributes {
    // FIX: ContentState updated to include taskNumber
    public struct ContentState: Codable, Hashable {
        var taskString: String
        var taskNumber: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String // e.g., "Daily Planner"
}

// MARK: - Preview Extensions (FIXED ACCESS CONTROL)

extension TaskWidgetAttributes {
    // ⭐️ FIX 1: Changed `fileprivate static` to just `static`
    public static var preview: TaskWidgetAttributes {
        TaskWidgetAttributes(name: "Remember")
    }
}

extension TaskWidgetAttributes.ContentState {
    // ⭐️ FIX 2: Changed `fileprivate static` to just `static`
    public static var sample: TaskWidgetAttributes.ContentState {
        TaskWidgetAttributes.ContentState(taskString: "Project report", taskNumber: 1)
    }

    // ⭐️ FIX 3: Changed `fileprivate static` to just `static`
    public static var sample2: TaskWidgetAttributes.ContentState {
        TaskWidgetAttributes.ContentState(taskString: "Call client, review notes", taskNumber: 2)
    }
}
