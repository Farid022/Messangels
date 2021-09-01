//
//  EditSubscriptionView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack

struct EditSubscriptionView: View {
    var body: some View {
        MenuBaseView(title: "Abonnement") {
            StatusView()
            RateView()
            PaymentView()
            StorageSpaceView()
            UnsubscribeSection()
        }
    }
}

struct MembershipView: View {
    var text = ""
    var body: some View {
        HStack {
            Image(systemName: "checkmark")
                .foregroundColor(.accentColor)
            Text(text)
                .font(.system(size: 13))
            Spacer()
        }
    }
}

private struct StatusView: View {
    @EnvironmentObject var auth: Auth
    var body: some View {
        HStack {
            Text("Statut(s)")
                .fontWeight(.bold)
            Spacer()
        }
        HStack {
            Image("ic_member")
            Text("Membre depuis le \(strToDate(auth.user.registration_date ?? ""))")
                .font(.system(size: 13))
            Spacer()
        }
        .padding(.bottom)
        MembershipView(text: "Membre depuis le \(strToDate(auth.user.registration_date ?? ""))")
        MembershipView(text: "Abonné")
        MembershipView(text: "Ange-gardien")
        MembershipView(text: "Invité (Actif jusqu’au : 8/04/2021)")
        Spacer().frame(height: 20)
        SubscribeButton()
            .padding(.horizontal, -25)
        Spacer().frame(height: 20)
    }
}

func strToDate(_ dateStr: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    if let date = dateFormatter.date(from: dateStr) {
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    } else {
        return ""
    }
}

private struct RateView: View {
    var body: some View {
        HStack {
            Text("Forfait")
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.bottom)
        HStack {
            Text("Forfait actuel : 2€TTC/mois (500Mo)")
            Spacer()
        }
        HStack {
            Text("Prochaine date de prélèvement : 12/04/2021")
            Spacer()
        }
        .padding(.bottom)
        Button("Mes factures") {
            
        }
        .shadow(color: .gray.opacity(0.2), radius: 10)
        .buttonStyle(MyButtonStyle(padding: 50, foregroundColor: .black))
        .padding(.bottom)
    }
}

private struct PaymentView: View {
    var body: some View {
        HStack {
            Text("Moyen de paiement")
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.bottom)
        HStack {
            Text("La carte enregistrée pour votre prélèvement automatique mensuel est : ")
            Spacer()
        }
        .padding(.bottom)
        HStack {
            Text("Visa **** **** **** 98539")
            Spacer()
        }
        HStack {
            Text("Date de validité : 06/22")
            Spacer()
        }
        .padding(.bottom)
        Button("Modifier") {
            
        }
        .shadow(color: .gray.opacity(0.2), radius: 10)
        .buttonStyle(MyButtonStyle(padding: 50, foregroundColor: .black))
        .padding(.bottom)
    }
}

private struct StorageSpaceView: View {
    var body: some View {
        HStack {
            Text("Espace de stockage")
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.bottom)
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .frame(height: 20)
            Rectangle()
                .foregroundColor(.accentColor)
                .frame(width: 70, height: 20)
                .clipShape(CustomCorner(corners: [.topLeft, .bottomLeft]))
            Text("20%")
                .font(.system(size: 13))
                .foregroundColor(.white)
                .padding(.leading)
        }
        .shadow(color: .gray.opacity(0.2), radius: 10)
        .padding(.bottom)
        HStack {
            Text("Il vous reste 100Mo soit l’équivalent de 10 minutes de vidéo.")
                .font(.system(size: 13))
            Spacer()
        }
        .padding(.bottom)
        Button("Augmenter mon espace") {
            
        }
        .shadow(color: .gray.opacity(0.2), radius: 10)
        .buttonStyle(MyButtonStyle(padding: 50,foregroundColor: .black))
        .padding(.bottom)
    }
}

private struct UnsubscribeSection: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        HStack {
            Text("Désabonnement")
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.bottom)
        Button("Se désabonner") {
            navigationModel.pushContent("EditSubscriptionView") {
                UnsubscribeConfirmView()
            }
        }
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .buttonStyle(MyButtonStyle(padding: 50, foregroundColor: .black))
            .padding(.bottom)
    }
}

struct EditSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        EditSubscriptionView()
    }
}
