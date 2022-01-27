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
                    Marianne recevra votre demande sur :
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
                            case .success(let guardian):
                                DispatchQueue.main.async {
                                    print(guardian.id)
                                    navigationModel.pushContent("GuardianFormConfirmSendView") {
                                        GuardianFormDoneView(vm: vm)
                                    }
                                }
                            case .failure(let error):
                                print(error.error_description)
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
    }
}

//struct GuardianFormConfirmSendView_Previews: PreviewProvider {
//    static var previews: some View {
//        GuardianFormConfirmSendView()
//    }
//}
