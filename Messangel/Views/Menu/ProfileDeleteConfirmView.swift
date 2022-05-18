//
//  UnsubscribeView.swift
//  Messangel
//
//  Created by Saad on 5/26/21.
//

import SwiftUI
import NavigationStack

struct ProfileDeleteConfirmView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
            MenuBaseView(title: "Supprimer mon compte") {
                VStack(spacing: 30.0) {
                    HStack {
                        Text("Êtes-vous sûr de vouloir supprimer votre compte")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    Text(text)
                    Button("Oui, continuer") {
                        navigationModel.pushContent(String(describing: Self.self)) {
                            ProfileDeleteReasonView()
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
    En supprimant votre compte :

    - Vous perdrez toutes les informations enregistrées dans votre Messangel : nous ne conserverons aucune de vos données ni informations personnelles.

    - Vos protégés éventuels seront prévenus, mais devront trouver un autre Ange-gardien si nécessaire.
    """
