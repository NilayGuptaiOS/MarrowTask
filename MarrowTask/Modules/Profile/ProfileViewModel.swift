//
//  ProfileViewModel.swift
//  MarrowTask
//
//  Created by Nilay on 25/04/25.
//

import Foundation
import SwiftUI

class ProfileViewModel {
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    func formattedDuration(_ interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits =
            interval > 3600 ? [.hour, .minute, .second] : [.minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: interval) ?? "0s"
    }

}
