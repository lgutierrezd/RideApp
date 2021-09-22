//
//  RingView.swift
//  RiderApp
//
//  Created by Luis Gutierrez on 20/9/21.
//

import SwiftUI

struct RingView: View {
    
    var percentage: Double
    var startColor: Color
    var endColor: Color
    
    var body: some View {
        let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
        let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
        let gradient =  AngularGradient(gradient: Gradient(colors: [gradientStart, gradientEnd]), center: .center, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360))
        return ZStack {
            RingBackgroundShape()
            RingShape(currentPercentage: percentage)
                .fill(gradient)
                .rotationEffect(.init(degrees: -90))
                .shadow(radius: 2)
                .drawingGroup()
                .animation(.easeInOut)
        }
    }
}

struct RingShape: Shape {
    
    var currentPercentage: Double
    
    func path(in rect: CGRect) -> Path {
        let thickness: CGFloat = 30
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = rect.width / 2 - thickness
        
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360 * currentPercentage), clockwise: false)
        
        return path.strokedPath(.init(lineWidth: thickness, lineCap: .round, lineJoin: .round))
    }
    
    var animatableData: Double{
        get {return currentPercentage}
        set {currentPercentage = newValue}
    }
}

struct RingBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        let thickness: CGFloat = 30
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = rect.width / 2 - thickness
        
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: false)
        
        return path.strokedPath(.init(lineWidth: thickness, lineCap: .round, lineJoin: .round))
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(percentage: 0.3, startColor: Color.red, endColor: Color.pink)
    }
}
