//
//  NotificationsView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI

struct NotificationsView: View {
    @State private var notifications1 = false
    @State private var notifications2 = false
    @State private var notifications3 = false
    @State private var alert1 = true
    @State private var alert2 = false
    var body: some View {
        MenuBaseView(title: "Notifications et alertes SMS") {
            HStack {
                Text("Notifications")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom)
            NotificationView(isOn: $notifications1, text: "Notifications 1", desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam.")
            NotificationView(isOn: $notifications2, text: "Notifications 1", desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam.")
            NotificationView(isOn: $notifications3, text: "Notifications 1", desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam.")
            HStack {
                Text("Alertes SMS")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom)
            NotificationView(isOn: $alert1, text: "Alertes 1", desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam.")
            NotificationView(isOn: $alert2, text: "Alertes 2", desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam.")
        }
    }
}

private struct NotificationView: View {
    @Binding var isOn: Bool
    var text: String
    var desc: String
    var body: some View {
        Toggle(text, isOn: $isOn)
            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            .padding(.bottom)
        Text(desc)
            .foregroundColor(.secondary)
            .font(.system(size: 13))
            .padding(.bottom)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
