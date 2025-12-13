//
//  TaskWidgetLiveActivity.swift
//  TaskWidget
//
//  Created by HOCC on 12/13/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

// MARK: - Live Activity Widget

struct TaskWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TaskWidgetAttributes.self) { context in
            HStack(spacing: 16) {
                Image("remember_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 36)
                
                Text(context.state.taskString)
                    .font(.headline)
                    .foregroundColor(Color.black)
                Spacer()
            }
            .padding()
            .activityBackgroundTint(.white)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI for Dynamic Island
                DynamicIslandExpandedRegion(.leading) {
                    VStack {
                        Image("remember_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                    }
                    .frame(maxHeight: .infinity)
                }
                DynamicIslandExpandedRegion(.center) {
                    VStack(alignment: .leading) {
                        Text(context.state.taskString)
                            .font(.headline)
                    }
                }
            } compactLeading: {
                Image("SfAppIcon")
                    .foregroundColor(Color.yellow)
            } compactTrailing: {
                Text(context.state.taskNumber.formatted())
                    .foregroundColor(Color.yellow)
                    .frame(width: 20)
            } minimal: {
                Image("SfAppIcon")
                    .foregroundColor(Color.yellow)
            }
        }
    }
}

// MARK: - Previews

#Preview("Lock Screen/Banner", as: .content, using: TaskWidgetAttributes.preview) {
    TaskWidgetLiveActivity()
} contentStates: {
    TaskWidgetAttributes.ContentState.sample;
    TaskWidgetAttributes.ContentState.sample2
}

#Preview("Dynamic Island Expanded", as: .dynamicIsland(.expanded), using: TaskWidgetAttributes.preview) {
    TaskWidgetLiveActivity()
} contentStates: {
    TaskWidgetAttributes.ContentState.sample;
    TaskWidgetAttributes.ContentState.sample2
}

#Preview("Dynamic Island Compact", as: .dynamicIsland(.compact), using: TaskWidgetAttributes.preview) {
    TaskWidgetLiveActivity()
} contentStates: {
    TaskWidgetAttributes.ContentState.sample2
}
