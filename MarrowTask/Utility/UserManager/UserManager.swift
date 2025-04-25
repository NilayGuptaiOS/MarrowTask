//
//  UserManager.swift
//  MarrowTask
//
//  Created by Nilay on 25/04/25.
//

import Foundation

class UserManager: ObservableObject {
    @Published var profile: UserProfile {
        didSet {
            saveProfile()
        }
    }

    private let userKey = "UserProfile"

    init() {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let saved = try? JSONDecoder().decode(UserProfile.self, from: data) {
            self.profile = saved
        } else {
            // Prefill default user profile
            self.profile = UserProfile(name: "Nilay Gupta", imageName: "person.crop.circle.fill")
            saveProfile()
        }
    }

    private func saveProfile() {
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: userKey)
        }
    }

    func updateProfile(name: String, imageName: String) {
        profile = UserProfile(name: name, imageName: imageName)
    }
}
