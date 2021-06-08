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
                    marianne.milon@gmail.com.
                    """
                    )
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    Spacer().frame(height: 10)
                    Button("Envoyer ma demande") {
                        navigationModel.pushContent("GuardianFormConfirmSendView") {
                            GuardianFormDoneView()
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

struct GuardianFormConfirmSendView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianFormConfirmSendView()
    }
}
