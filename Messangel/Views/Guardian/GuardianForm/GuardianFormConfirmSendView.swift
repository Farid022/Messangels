//
//  SignupDoneView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI
import NavigationStack

struct GuardianFormConfirmSendView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: GuardianViewModel
    @State var alert = false
    @State var error = ""
    var body: some View {
        NavigationStackView("GuardianFormConfirmSendView") {
            ZStack {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    HStack {
                        BackButton()
                        Spacer()
                    }
                    Spacer()
                    Text("Confirmer l’envoi")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                    Text(
                        """
                    \(vm.guardian.last_name) recevra votre demande sur :
                    \(vm.guardian.email)
                    """
                    )
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    Spacer().frame(height: 10)
                    Button("Envoyer ma demande") {
                        vm.guardian.user_id = getUserId()
                        APIService.shared.post(model: vm.guardian, response: vm.guardian, endpoint: "users/guardian") { result in
                            switch result {
                            case .success(_):
                                DispatchQueue.main.async {
                                    vm.guardiansUpdated = true
                                    navigationModel.pushContent("GuardianFormConfirmSendView") {
                                        GuardianFormDoneView(vm: vm)
                                    }
                                }
                            case .failure(let error):
                                self.error = error.error_description
                                alert.toggle()
                            }
                        }
                    }
                        .buttonStyle(MyButtonStyle())
                        .accentColor(.black)
                    Spacer()
                }.padding()
            }
            .foregroundColor(.white)
        }
        .alert("Désolé", isPresented: $alert, actions: {
            Button("OK", role: .cancel) {}
        }, message: {
            Text(self.error)
        })
    }
}
