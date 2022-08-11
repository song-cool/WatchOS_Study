//
//  OutlineView.swift
//  WatchWeather WatchKit Extension
//
//  Created by 송시원 on 2022/08/10.
//

import SwiftUI

struct OutlineView: View {
    var body: some View {
 RoundedRectangle(cornerRadius: 10)
            .stroke(LinearGradient(gradient: Gradient(colors:[Color.purple, Color.blue, Color.blue.opacity(0.4)]), startPoint: .topLeading, endPoint: .trailing), lineWidth: 4)
            .padding()
    }
}

struct OutlineView_Previews: PreviewProvider {
    static var previews: some View {
        OutlineView()
    }
}
