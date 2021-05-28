//
//  SignupDoneView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI

struct GuardianFormConfirmSendView: View {
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                Text("Confirmer l’envoi")
                    .font(.title2)
                    .fontWeight(.bold)
                Text(
                    """
                Marianne recevra votre demande sur :
                marianne.milon@gmail.com.
                """
                )
                .multilineTextAlignment(.center)
                Spacer().frame(height: 10)
                NavigationLink("Envoyer ma demande", destination: TabBarView())
                    .isDetailLink(false)
                    .buttonStyle(MyButtonStyle())
                    .accentColor(.black)
                Spacer()
            }.padding()
        }
        .foregroundColor(.white)
    }
}

struct GuardianFormConfirmSendView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianFormConfirmSendView()
    }
}
