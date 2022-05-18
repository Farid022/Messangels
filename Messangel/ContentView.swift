//
//  ContentView.swift
//  Messangel
//
//  Created by Saad on 5/8/21.
//

import SwiftUI
import NavigationStack

struct ContentView: View {
    @StateObject var auth = Auth()
    @StateObject private var subVM = SubscriptionViewModel()
    @StateObject var keyAccRegVM = AccStateViewModel()
    @StateObject private var vmWishes = WishesViewModel()

    let editor: RichEditorView
    
    init() {
        self.editor = RichEditorView(frame: .zero)
    }
    
    var body: some View {
        Group {
            if !auth.user.first_name.isEmpty {
                TabBarView()
            } else {
                StartView()
                    .background(Color.accentColor.ignoresSafeArea())
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            if !auth.user.first_name.isEmpty && !subVM.gotSubscription {
                if let window = UIApplication.keyWindow {
                    window.rootViewController = UIHostingController(rootView: ContentView())
                    window.makeKeyAndVisible()
                }
            }
        }
        .onAppear() {
            if let user = UserDefaults.standard.value(forKey: "user") as? [String: Any] {
                do {
                    let json = try JSONSerialization.data(withJSONObject: user)
                    let decoder = JSONDecoder()
                    let decodedUser = try decoder.decode(User.self, from: json)
                    auth.user = decodedUser
                    auth.credentials = Credentials(email: auth.user.email, password: auth.user.password ?? "")
                    auth.getToken { success in
                        if success {
                            print("Got token successfully.")
                            subVM.checkSubscription()
                        } else {
                            print("Token fetch failed!")
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
        .environmentObject(auth)
        .environmentObject(NavigationModel())
        .environmentObject(editor)
        .environmentObject(keyAccRegVM)
        .environmentObject(subVM)
        .environmentObject(vmWishes)
    }
}
