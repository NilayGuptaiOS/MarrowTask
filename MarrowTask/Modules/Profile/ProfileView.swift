//
//  Profile.swift
//  MarrowTask
//
//  Created by Nilay on 25/04/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userManager: UserManager

    var sessionHistory: [FocusSession] {
            sessionManager.sessionHistory
        }

    var badges: [String]  = []
    let viewModel = ProfileViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // User Image
                Image(systemName: userManager.profile.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.blue)
                    .padding(.top, 40)

                // User Name
                Text(userManager.profile.name)
                    .font(.title)
                    .fontWeight(.bold)


                // Badges
                VStack(spacing: 10) {
                    Text("Badges")
                        .font(.headline)

                    HStack(spacing: 16) {
                        ForEach(badges, id: \.self) { badge in
                            Image(systemName: badge)
                                .font(.title)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .clipShape(Circle())
                                .foregroundColor(.blue)
                        }
                    }
                }

                Divider().padding(.horizontal)

                // Recent Sessions
                VStack(alignment: .leading, spacing: 10) {
                    Text("Recent Sessions")
                        .font(.headline)
                        .padding(.leading)

                    ForEach(sessionHistory.reversed(), id: \.self) { session in
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.gray)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Mode: \(session.mode)")
                                    .font(.headline)
                                Text("Started: \(viewModel.formattedDate(session.startTime))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Duration: \(viewModel.formattedDuration(session.duration))")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)

                                Text("Points: \(session.points) • Badges: \(session.badges.joined(separator: " "))")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                }
            }
            .padding(.bottom, 40)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }

    }


#Preview {
    ProfileView()
}
