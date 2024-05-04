//
//  RingChart.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 02.05.2024.
//

import SwiftUI

struct RingChart: View {
    var percentage: Double 
    
    private let lineWidth: CGFloat = 20.0
    
    var body: some View {
        let formattedPercentage = String(format: "%.0f", percentage)
        
        return ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth))
                .frame(width: 100, height: 100)
            
            Circle()
                .trim(from: 0, to: CGFloat(percentage / 100))
                .stroke(Color.blue, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: -90))
            
            Text("\(formattedPercentage)%")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}
