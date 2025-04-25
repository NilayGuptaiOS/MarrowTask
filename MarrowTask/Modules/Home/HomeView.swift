//
//  HomeView.swift
//  MarrowTask
//
//  Created by Nilay on 25/04/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var sessionManager: SessionManager
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Focus Modes")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)

                VStack(spacing: 20) {
                    FocusButton(
                        title: "Work",
                        icon: "briefcase.fill",
                        color: LinearGradient(
                            colors: [.blue, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        focusType: "Work"
                    )
                    FocusButton(
                        title: "Play",
                        icon: "play.fill",
                        color: LinearGradient(
                            colors: [.teal, .green],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        focusType: "Play"
                    )

                    FocusButton(
                        title: "Rest",
                        icon: "face.smiling",
                        color: LinearGradient(
                            colors: [.mint, .teal],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        focusType: "Rest"
                    )

                    FocusButton(
                        title: "Sleep",
                        icon: "moon.fill",
                        color: LinearGradient(
                            colors: [.purple, .indigo],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        focusType: "Sleep"
                    )

                }
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius: 10)
                .padding(.horizontal, 20)

                Spacer()
                NavigationLink(destination: ProfileView()) {
                    Text("Go to Profile")
                        .foregroundColor(.blue)
                        .font(.body)
                }
                Spacer()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
#Preview {
    HomeView()
}
