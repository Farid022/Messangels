//
//  GuardianView.swift
//  Messangel
//
//  Created by Saad on 10/13/21.
//

import SwiftUI
import NavigationStack

struct DeathConfirmationView: View {
    @ObservedObject var vm: GuardianViewModel
    @EnvironmentObject var navigationModel: NavigationModel
    var protected: MyProtected
    
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
            MenuBaseView(title:"\(protected.user.last_name) \(protected.user.first_name)") {
                ProfileImageView(imageUrlString: protected.user.image_url)
                    .padding(.vertical)
                Text(protected.user.last_name + " " + protected.user.first_name.uppercased())
                    .font(.system(size: 20), weight: .bold)
                Spacer().frame(height: 50)
                Text("Demande de confirmation de décès")
                    .font(.system(size: 20), weight: .bold)
                Text(confirmationText)
                    .multilineTextAlignment(.center)
                Button(action: {
                    navigationModel.pushContent(TabBarView.id) {
                        ConfirmDeathIntro(vm: vm)
                    }
                }, label: {
                    Text("Oui")
                })
                .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .black))
                Spacer().frame(height: 30)
                Button(action: {
                    let deathReject = ["death_dec" : 1, "status": 3, "guardian" : getUserId()]
                    APIService.shared.post(model: deathReject, response: vm.apiResponse, endpoint: "users/\(getUserId())/death_reject") { result in
                        DispatchQueue.main.async {
                            vm.guardiansUpdated = true
                            withAnimation {
                                navigationModel.popContent(TabBarView.id)
                            }
                        }
                    }
                }, label: {
                    Text("Non")
                })
                .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .gray))
                Spacer().frame(height: 70)
                Text("Plus d’informations")
                    .underline()
            }
        }
    }
    let confirmationText = """
Nous avons le regret de vous annoncer que Henri Death a été déclaré comme décédé par son Ange-gardien : Sophie Carnero.

En tant qu’Ange-gardien, confirmez-vous cette déclaration ?

"""
}
