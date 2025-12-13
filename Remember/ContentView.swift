//
//  ContentView.swift
//  Remember
//
//  Created by HOCC on 12/6/25.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var tasks: [String] = []
    @State private var isRunning: Bool = false
    let liveActivityManager = LiveActivityManager()


    var body: some View {
        NavigationStack {
            VStack(spacing: 0) { // Setting spacing to 0 for better control
                if !tasks.isEmpty {
                    List {
                        ForEach(tasks.indices, id: \.self) { index in
                            HStack {
                                Text(tasks[index])
                                    .font(.body)
                            }
                        }
                        .onDelete(perform: deleteTask)
                    }
                    .scrollDisabled(true)
                    .frame(height: CGFloat(tasks.count * 52)) // Adjust height
                    .listStyle(.insetGrouped)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    if (!tasks.isEmpty) {
                        Divider()
                    }
                    
                    TextField("Things you want to remember", text: $inputText)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 52))
                        .textFieldStyle(.automatic)
                        .submitLabel(.done)
                        .onSubmit {
                            handleStart()
                        }
                    
                    Button(action: handleStart) {
                        Label("Start", systemImage: "play.fill")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .controlSize(.large)
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func handleStart() {
        // 1. Update UI state (This is correct)
        withAnimation {
            // Add the new task and clear the input text
            tasks.append(inputText)
            inputText = ""
            isRunning = true
        }
        
        // Check if we are starting a brand new activity or updating an existing one
        // NOTE: Live Activities should be started outside the animation block.
        
        if (tasks.count > 1) {
            // We have more than one task, so we are updating the Live Activity.
            
            // 2. FIX: Use .joined(separator:) for efficient string concatenation.
            let taskString = tasks.joined(separator: ", ")
            
            // The task number for an *update* should generally be the count of tasks,
            // or the index of the last added item if you're tracking progress.
            // We will use the count here as a placeholder for the total tasks.
            let taskCount = tasks.count
            
            // 3. FIX: Passed the dynamically calculated values
            liveActivityManager.updateLiveActivity(
                taskString: taskString,
                taskNumber: taskCount
            )
            
        } else if tasks.count == 1 {
            // We have exactly one task, so we START the Live Activity.
            
            // 4. FIX: Use index 0 for the first (and only) task.
            let firstTask = tasks[0]
            
            liveActivityManager.startLiveActivity(
                taskString: firstTask,
                taskNumber: 1
            )
        }
        // Note: If tasks.count == 0, the function does nothing after the initial block.
    }
    
    func handlePause() {
        withAnimation {
            isRunning = false
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        if (tasks.count > 0) {
            // We have more than one task, so we are updating the Live Activity.
            
            // 2. FIX: Use .joined(separator:) for efficient string concatenation.
            let taskString = tasks.joined(separator: ", ")
            
            // The task number for an *update* should generally be the count of tasks,
            // or the index of the last added item if you're tracking progress.
            // We will use the count here as a placeholder for the total tasks.
            let taskCount = tasks.count
            
            // 3. FIX: Passed the dynamically calculated values
            liveActivityManager.updateLiveActivity(
                taskString: taskString,
                taskNumber: taskCount
            )
            
        } else {
            liveActivityManager.endLiveActivity()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

