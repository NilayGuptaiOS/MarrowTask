//
//  SessionManager.swift
//  MarrowTask
//
//  Created by Nilay on 25/04/25.
//

import Foundation

class SessionManager: ObservableObject {
    @Published var currentSession: FocusSession?
    @Published var sessionHistory: [FocusSession] = []

    private let sessionKey = "ActiveFocusSession"
    private let historyKey = "FocusSessionHistory"


    init() {
        loadSession()
        loadHistory()
    }

    func startSession(mode: String) {
        let session = FocusSession(mode: mode, startTime: Date(), points: 0, badges: [])
        currentSession = session
        saveSession()
    }

    func updateSession(points: Int, badges: [String]) {
        guard var session = currentSession else { return }
        session.points = points
        session.badges = badges
        currentSession = session
        saveSession()
    }


    private func saveSession() {
        currentSession?.endTime = Date()
        if let data = try? JSONEncoder().encode(currentSession) {
            UserDefaults.standard.set(data, forKey: sessionKey)
        }
    }

    private func loadSession() {
        guard let data = UserDefaults.standard.data(forKey: sessionKey),
              let session = try? JSONDecoder().decode(FocusSession.self, from: data) else {
            return
        }
        currentSession = session
    }
    private func saveHistory() {
        if let data = try? JSONEncoder().encode(sessionHistory) {
            UserDefaults.standard.set(data, forKey: historyKey)
        }
    }

    private func loadHistory() {
        guard let data = UserDefaults.standard.data(forKey: historyKey),
              let history = try? JSONDecoder().decode([FocusSession].self, from: data) else {
            sessionHistory = []
            return
        }
        sessionHistory = history
    }
    func endSession() {
        if let session = currentSession {
            loadHistory()
            sessionHistory.append(session)
            saveHistory()
        }
        
        saveSession()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.currentSession = nil
            UserDefaults.standard.removeObject(forKey: self.sessionKey)
        }
        
    }

}
