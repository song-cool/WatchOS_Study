//
//  NotificationView.swift
//  WatchLandmarks WatchKit Extension
//
//  Created by 송시원 on 2022/07/25.
//  Copyright © 2022 Apple. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    var title: String?
    var message: String?
    var landmark: Landmark?
    
    var body: some View {
        VStack{
            if landmark != nil {
                CircleImage(image: landmark!.image.resizable())
                    .scaledToFit()
            }
            Text(title ?? "Unknown Landmark")
                .font(.headline)
            Divider()
            
            Text(message ?? "You are within 5 miles of one of your favorite landmarks.")
                .font(.caption)
        }
        .lineLimit(0)
        
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
        NotificationView(title: "Turtle Rock",
                         message: "You are within 5 miles of Turtle Rock.",
                         landmark: ModelData().landmarks[0])
    }
}
