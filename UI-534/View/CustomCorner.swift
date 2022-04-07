//
//  CustomCorner.swift
//  UI-534
//
//  Created by nyannyan0328 on 2022/04/07.
//

import SwiftUI

struct CustomCorner: Shape {
    var radi : CGFloat
    var corner : UIRectCorner
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radi, height: radi))
        
        return Path(path.cgPath)
    }
}
