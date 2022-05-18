//
//  UnsubscribeReasonView.swift
//  Messangel
//
//  Created by Saad on 5/26/21.
//

import SwiftUI
import NavigationStack

struct ProfileDeleteReasonView: View {
    
    @State private var showAlert = false
    var body: some View {
        ZStack{
            MenuBaseView(title: "Supprimer mon compte") {
                VStack(spacing: 30.0) {
                    HStack {
                        Text("Nous sommes désolés d’apprendre votre choix.")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    Text("Quelles sont les raisons qui vous poussent à supprimer votre compte ?")
                    ChoicesView()
                    
                    Button("Supprimer mon compte") {
                        withAnimation {
                            showAlert = true
                        }
                    }
                    .buttonStyle(MyButtonStyle(padding: 50,foregroundColor: .white, backgroundColor: .black))
                    .normalShadow()
                }
            }
            if showAlert {
                ConfirmProfileDeleteAlert(isPresented: $showAlert, title: "Vous n’êtes plus membre", bodyText: "Si vous changez d’avis, vous pouvez vous inscrire à nouveau sur Messangel", buttonText: "OK")
            }
        }
    }
}

struct ConfirmProfileDeleteAlert: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @EnvironmentObject var auth: Auth
    @Binding var isPresented: Bool
    var title: String
    var bodyText: String
    var buttonText: String
    
    var body: some View {
        Color.black
            .opacity(0.2)
            .ignoresSafeArea()
        VStack(spacing: 15) {
            Text(title)
                .bold()
            Text(bodyText)
                .multilineTextAlignment(.center)
                .font(.system(size: 13))
            Divider()
            Button(action: {
                Task {
                    deleteProfile()
                }
            }) {
                Text(buttonText)
                    .foregroundColor(.accentColor)
            }
        }
        .frame(width: 270)
        .padding(20)
        .background(
            Color.white
                .cornerRadius(20)
        )
    }
    
    func deleteProfile() {
        APIService.shared.delete(endpoint: "users/\(getUserId())/profile", completion: { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    auth.removeUser()
                    navigationModel.pushContent(TabBarView.id) {
                        StartView()
                    }
                }
            case .failure(let error):
                print(error.error_description)
            }
        })
    }
}
