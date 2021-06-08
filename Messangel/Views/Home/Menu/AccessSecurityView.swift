//
//  AccessSecurityView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI

struct AccessSecurityView: View {
    var body: some View {
        MenuBaseView(title: "Accès et sécurité") {
            Text("Ces informations garantissent votre accès et la transmission de votre Messangel à vos anges-gardiens. Ne les modifiez qu’en cas de nécessité.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding()
            AccessView(title: "Mot de passe Messangel", subTitle: "************", action: {})
            AccessView(title: "Adresse mail associée au compte", subTitle: "sophie.carnero@gmail.com", action: {})
            AccessView(title: "Téléphone mobile associé au compte", subTitle: "06 00 00 00 00", action: {})
        }
    }
}

private struct AccessView: View {
    var title = ""
    var subTitle = ""
    var action: () -> ()
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Text(subTitle)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.bottom)
        Button("Modifier") {
            action()
        }
        .shadow(color: .gray.opacity(0.2), radius: 10)
        .padding(.bottom, 30)
        .buttonStyle(MyButtonStyle(foregroundColor: .black))
    }
}

struct AccessSecurityView_Previews: PreviewProvider {
    static var previews: some View {
        AccessSecurityView()
    }
}
