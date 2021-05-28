//
//  UnsubscribeView.swift
//  Messangel
//
//  Created by Saad on 5/26/21.
//

import SwiftUI

struct UnsubscribeConfirmView: View {
    var body: some View {
        MenuBaseView(title: "Désabonnement") {
            VStack(spacing: 30.0) {
                HStack {
                    Text("Êtes-vous sûr de vouloir vous désabonner ?")
                        .fontWeight(.bold)
                    Spacer()
                }
                Text(text)
                NavigationLink("Oui, continuer", destination: UnsubscribeReasonView())
                    .isDetailLink(false)
                    .buttonStyle(MyButtonStyle(foregroundColor: .black))
                    .shadow(color: .gray.opacity(0.2), radius: 10)
            }
        }
    }
}

private let text = """
    En vous désabonnant :

    - Vous perdrez toutes les informations enregistrées dans votre Messangel. Après 30 jours, vos messages, choix et données de vie digitale seront supprimés définitivement.

    - Vous conserverez votre rôle d’Ange-gardien le cas échéant. Si vous désirez vous retirer du rôle d’Ange-gardien, supprimez vos protégés dans : Accueil>Mes protégés. Pensez à prévenir ces personnes.
    """

struct UnsubscribeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UnsubscribeConfirmView()
        }
    }
}
