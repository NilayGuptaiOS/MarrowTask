//
//  LaunchScreenView.swift
//  MarrowTask
//
//  Created by Nilay on 25/04/25.
//

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject var sessionManager: SessionManager

    @State private var isReady = false

    var body: some View {
        Group {
            if isReady {
                if sessionManager.currentSession != nil {
                    TimerView(mode: sessionManager.currentSession?.mode ?? "Play")
                } else {
                    HomeView()
                }
            } else {
                VStack {
                    ProgressView("Restoring Session...")
                        .padding()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isReady = true
                    }
                }
            }
        }
    }
}
