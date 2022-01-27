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
    @StateObject var keyAccRegVM = AccStateViewModel()
    let editor: RichEditorView
    
    init() {
//        self.auth = Auth()
        self.editor = RichEditorView(frame: .zero)
        
     
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        appearance.largeTitleTextAttributes = [
//            .font : UIFont.boldSystemFont(ofSize: 34),
//            NSAttributedString.Key.foregroundColor : UIColor.white
//        ]
//        appearance.titleTextAttributes = [
//            .font : UIFont.systemFont(ofSize: 17, weight: .semibold),
//            NSAttributedString.Key.foregroundColor : UIColor.white
//        ]
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().tintColor = .white
//        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(.accentColor)

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
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
