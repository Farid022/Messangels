//
//  UnsubscribeView.swift
//  Messangel
//
//  Created by Saad on 5/26/21.
//

import SwiftUI
import NavigationStack

struct UnsubscribeConfirmView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        NavigationStackView("UnsubscribeConfirmView") {
            MenuBaseView(title: "Désabonnement") {
                VStack(spacing: 30.0) {
                    HStack {
                        Text("Êtes-vous sûr de vouloir vous désabonner ?")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    Text(text)
                    Button("Oui, continuer") {
                        navigationModel.pushContent("UnsubscribeConfirmView") {
                            UnsubscribeReasonView()
                        }
                    }
                        .buttonStyle(MyButtonStyle(foregroundColor: .black))
                        .normalShadow()
                }
            }
        }
    }
}

private let text = """
    En vous désabonnant :

    - Vous perdrez toutes les informations enregistrées dans votre Messangel. Après 30 jours, vos messages, choix et données de vie digitale seront supprimés définitivement.

    - Vous conserverez votre rôle d’Ange-gardien le cas échéant. Si vous désirez vous retirer du rôle d’Ange-gardien, supprimez vos protégés dans : Accueil>Mes protégés. Pensez à prévenir ces personnes.
    """
