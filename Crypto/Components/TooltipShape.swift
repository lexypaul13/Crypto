//
//  TooltipShape.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct TooltipShape: Shape {
    
    private let tipWidth: CGFloat
    private let tipHeight: CGFloat
    private let cornerRadius: CGFloat
    
    init(cornerRadius: CGFloat = 24.0, tipSize: CGSize = CGSize(width: 20.0, height: 20.0)) {
        self.tipWidth = tipSize.width
        self.tipHeight = tipSize.height
        self.cornerRadius = cornerRadius
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: (rect.minY + tipHeight + cornerRadius)))
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: (rect.minY + tipHeight  + cornerRadius)),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: 270),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.midX - (tipWidth/2), y: (rect.minY + tipHeight)))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX + (tipWidth/2), y: (rect.minY + tipHeight)))
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: (rect.minY + tipHeight)))
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: (rect.minY + tipHeight  + cornerRadius)),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 270),
                        endAngle: Angle(degrees: 0),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX , y: (rect.maxY - cornerRadius)))
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: (rect.maxY - cornerRadius)),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 90),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius , y: rect.maxY))
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: (rect.maxY - cornerRadius)),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 180),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: (rect.minY + tipHeight + cornerRadius)))
        }
    }
}
