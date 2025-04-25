//
//  TimerView.swift
//  MarrowTask
//
//  Created by Nilay on 25/04/25.
//

import SwiftUI

import SwiftUI

struct TimerView: View {
    var mode : String
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var timeElapsed: TimeInterval = 0
    @State private var timerRunning = true
    @State private var points = 0
    @State private var badges: [String] = []
    @State private var showStopAlert = false
    let treeBadges = ["🌵", "🎄", "🌲", "🌳", "🌴"]
    let leafBadges = ["🍂", "🍁", "🍄"]
    let animalBadges = ["🐅", "🦅", "🐵", "🐝"]

    var allBadges: [String] {
        treeBadges + leafBadges + animalBadges
    }

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("\(sessionManager.currentSession?.mode ?? mode) Mode")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(formattedTime)
                .font(.system(size: 48, weight: .medium, design: .monospaced))
                .padding()

            Text("Points: \(sessionManager.currentSession?.points ?? points)")
                .font(.title2)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach((sessionManager.currentSession?.badges.indices ?? 0..<0), id: \.self) { index in
                        Text(sessionManager.currentSession?.badges[index] ?? "")
                            .font(.system(size: 40))
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
            }

            Button("Stop Focus Mode") {
                showStopAlert = true
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(12)
            .alert(isPresented: $showStopAlert) {
                Alert(
                    title: Text("Stop Focus Session?"),
                    message: Text("You’ll end the current session. Are you sure?"),
                    primaryButton: .destructive(Text("Stop")) {
                        sessionManager.endSession()
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }


            Spacer()
        }
        .padding()
        .onAppear {
                    if let session = sessionManager.currentSession {
                        timeElapsed = Date().timeIntervalSince(session.startTime)
                    }
                }
        .onReceive(timer) { _ in
                    guard timerRunning else { return }
            if timeElapsed == 0 {
                sessionManager.startSession(mode: mode)
            }
                    timeElapsed += 1
            
                    if Int(timeElapsed) % 10 == 0 {
                        var newPoints = sessionManager.currentSession?.points ?? 0
                        var newBadges = sessionManager.currentSession?.badges ?? []
                        newPoints += 1
                        newBadges.append(randomBadge())
                        sessionManager.updateSession(points: newPoints, badges: newBadges)
                    }
                }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }

    var formattedTime: String {
        if timeElapsed >= 3600 {
            let hours = Int(timeElapsed) / 3600
            let minutes = (Int(timeElapsed) % 3600) / 60
            let seconds = Int(timeElapsed) % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            let minutes = Int(timeElapsed) / 60
            let seconds = Int(timeElapsed) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }

    func randomBadge() -> String {
        allBadges.randomElement() ?? "🍁"
    }

}
#Preview {
    TimerView(mode: "")
}
