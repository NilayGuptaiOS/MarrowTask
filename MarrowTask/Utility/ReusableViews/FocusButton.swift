//
//  FocusButton.swift
//  MarrowTask
//
//  Created by Nilay on 25/04/25.
//
import SwiftUI

struct FocusButton: View {
    var title: String
    var icon: String
    var color: LinearGradient
    var focusType: String

    var body: some View {
        NavigationLink(destination: TimerView(mode: focusType)) {
            HStack {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.white)
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .cornerRadius(20)
        }
    }
}
