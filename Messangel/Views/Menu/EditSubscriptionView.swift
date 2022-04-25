//
//  EditSubscriptionView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack

struct EditSubscriptionView: View {
    @EnvironmentObject private var subVM: SubscriptionViewModel
    var body: some View {
        NavigationStackView("EditSubscriptionView") {
            MenuBaseView(title: "Abonnement") {
                StatusView()
                RateView()
                PaymentView()
                StorageSpaceView()
                if !subVM.subscriptions.isEmpty {
                    UnsubscribeSection()
                }
            }
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
            Spacer()
        }
    }
}

private struct StatusView: View {
    @EnvironmentObject var auth: Auth
    @EnvironmentObject private var subVM: SubscriptionViewModel
    var body: some View {
        HStack {
            Text("Statut(s)")
                .fontWeight(.bold)
            Spacer()
        }
        HStack {
            Image("ic_member")
            Text("Membre depuis le \(unixStrToDateSring(auth.user.registration_date ?? ""))")
            Spacer()
        }
        .padding(.bottom)
        MembershipView(text: "Membre depuis le \(unixStrToDateSring(auth.user.registration_date ?? ""))")
        MembershipView(text: "Abonné")
        MembershipView(text: "Ange-gardien")
        MembershipView(text: "Invité (Actif jusqu’au : 8/04/2021)")
        Spacer().frame(height: 20)
        if subVM.subscriptions.isEmpty {
            SubscribeButton()
                .padding(.horizontal, -25)
        }
        Spacer().frame(height: 20)
    }
}

private struct RateView: View {
    @EnvironmentObject private var vm: SubscriptionViewModel
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
            Text("Prochaine date de prélèvement : \(unixStrToDateSring(vm.subscription.endDate ?? ""))")
            Spacer()
        }
        .padding(.bottom)
        Button("Mes factures") {
            
        }
        .normalShadow()
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
        .normalShadow()
        .buttonStyle(MyButtonStyle(padding: 50, foregroundColor: .black))
        .padding(.bottom)
    }
}

private struct StorageSpaceView: View {
    @EnvironmentObject private var vm: SubscriptionViewModel
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
                .frame(width: getStorageWidth(), height: 20)
                .clipShape(CustomCorner(corners: vm.subscription.consumptionInMB == "0.00" ? [.topLeft, .bottomLeft, .topRight, .bottomRight] : [.topLeft, .bottomLeft]))
            Text("\(String(format:"%.f", getRemainingStoragePercentage()))%")
                .font(.system(size: 13))
                .foregroundColor(.white)
                .padding(.leading)
        }
        .normalShadow()
        .padding(.bottom)
        HStack {
            Text("Il vous reste \(String(format:"%.f", getRemainingStorageMB()))Mo")
                .font(.system(size: 13))
            Spacer()
        }
        .padding(.bottom)
        Button("Augmenter mon espace") {
            
        }
        .normalShadow()
        .buttonStyle(MyButtonStyle(padding: 50,foregroundColor: .black))
        .padding(.bottom)
    }
    
    func getStorageWidth() -> Double {
        return (((UIScreen.main.bounds.width - 20) / 100.0) * (512.0 - (Double(vm.subscription.consumptionInMB ?? "0.0") ?? 0.0)) / 512.0 * 100.0)
    }
    
    func getRemainingStorageMB() -> Double {
        return 512.0 - (Double(vm.subscription.consumptionInMB ?? "0.0") ?? 0.0)
    }
    
    func getRemainingStoragePercentage() -> Double {
        return (512.0 - (Double(vm.subscription.consumptionInMB ?? "0.0") ?? 0.0)) / 512.0 * 100.0
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
            .normalShadow()
            .buttonStyle(MyButtonStyle(padding: 50, foregroundColor: .black))
            .padding(.bottom)
    }
}

//struct EditSubscriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditSubscriptionView()
//    }
//}
