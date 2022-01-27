//
//  AccessSecurityView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack

struct AccessSecurityView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var auth: Auth
    var body: some View {
        NavigationStackView("AccessSecurityView") {
            MenuBaseView(title: "Accès et sécurité") {
                AccessSecurityHeader()
                AccessView(title: "Mot de passe Messangel", subTitle: "************", action: {
                    navigationModel.pushContent("AccessSecurityView") {
                        ModifyPasswordView()
                    }
                })
                AccessView(title: "Adresse mail associée au compte", subTitle: auth.user.email, action: {
                    navigationModel.pushContent("AccessSecurityView") {
                        ModifyEmailView()
                    }
                })
                AccessView(title: "Téléphone mobile associé au compte", subTitle: auth.user.phone_number.separate(), action: {
                    navigationModel.pushContent("AccessSecurityView") {
                        ModifyMobileView()
                    }
                })
            }
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
        .normalShadow()
        .padding(.bottom, 30)
        .buttonStyle(MyButtonStyle(foregroundColor: .black))
    }
}

//struct AccessSecurityView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccessSecurityView()
//    }
//}

struct AccessSecurityHeader: View {
    var body: some View {
        Text("Ces informations garantissent votre accès et la transmission de votre Messangel à vos anges-gardiens. Ne les modifiez qu’en cas de nécessité.")
            .font(.system(size: 13))
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .padding()
    }
}
