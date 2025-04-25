//
//  SessionModel.swift
//  MarrowTask
//
//  Created by Nilay on 25/04/25.
//
import Foundation

struct FocusSession: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var mode: String
    var startTime: Date
    var endTime: Date?
    var points: Int
    var badges: [String]

    var duration: TimeInterval {
        guard let endTime = endTime else {
            return Date().timeIntervalSince(startTime)
        }
        return endTime.timeIntervalSince(startTime)
    }
}
