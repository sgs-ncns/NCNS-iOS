//
//  NotificationView.swift
//  SGS_NCNS
//
//  Created by 한상혁 on 2022/01/06.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        NavigationView {
            Text("Notification View")
            .navigationTitle("Notifications")
            .padding(0.0)
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
