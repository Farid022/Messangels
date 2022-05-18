//
//  WishesMenuView.swift
//  Messangel
//
//  Created by Saad on 10/14/21.
//

import SwiftUI
import NavigationStack

struct WishesMenuView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @StateObject private var vm = WishesViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Choix personnels")
                            .font(.system(size: 20), weight: .bold)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.bottom)
                    VStack(spacing: 20) {
                        ForEach(wishesPersonal) { wish in
                            WishCategoryCard(title: wish.name, desc: wish.desc, icon: wish.icon,
                                             progress: CGFloat(vm.wishesProgresses.last(where: {$0.tab == wish.id})?.progress ?? 0))
                                .onTapGesture {
                                    navigationModel.pushContent(TabBarView.id) {
                                        wish.destination
                                            .environmentObject(vm)
                                    }
                                }
                        }
                    }
                    HStack {
                        Text("Cérémonie")
                            .font(.system(size: 20), weight: .bold)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.bottom)
                    ForEach(wishesCeremony) { wish in
                        WishCategoryCard(title: wish.name, desc: wish.desc, icon: wish.icon,
                                         progress: CGFloat(vm.wishesProgresses.last(where: {$0.tab == wish.id})?.progress ?? 0))
                            .onTapGesture {
                                navigationModel.pushContent(TabBarView.id) {
                                    wish.destination
                                        .environmentObject(vm)
                                }
                            }
                    }
                    HStack {
                        Text("Transmission")
                            .font(.system(size: 20), weight: .bold)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.bottom)
                    ForEach(wishesTransport) { wish in
                        WishCategoryCard(title: wish.name, desc: wish.desc, icon: wish.icon,
                                         progress: CGFloat(vm.wishesProgresses.last(where: {$0.tab == wish.id})?.progress ?? 0))
                            .onTapGesture {
                                navigationModel.pushContent(TabBarView.id) {
                                    wish.destination
                                        .environmentObject(vm)
                                }
                            }
                    }
                    HStack {
                        Text("Complément")
                            .font(.system(size: 20), weight: .bold)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.bottom)
                    ForEach(wishesExtras) { wish in
                        WishCategoryCard(title: wish.name, desc: wish.desc, icon: wish.icon,
                                         progress: CGFloat(vm.wishesProgresses.last(where: {$0.tab == wish.id})?.progress ?? 0))
                            .onTapGesture {
                                navigationModel.pushContent(TabBarView.id) {
                                    wish.destination
                                        .environmentObject(vm)
                                }
                            }
                    }
                }
                .padding()
                
            }
            Spacer().height(70)
        }
        .task {
            vm.getProgress()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            if vm.wishesProgresses.isEmpty {
                vm.getProgress()
            }
        }
    }
}

struct WishCategory: Identifiable {
    var id: Int
    var name: String
    var desc: String
    var icon: String
    var destination: AnyView
}

let wishesPersonal = [
    WishCategory(id: 1, name: "Choix funéraires", desc: "Spiritualité et traditions au sein de votre cérémonie.", icon: "ic_funeral", destination: AnyView(FuneralChoiceIntro())),
    WishCategory(id: 2, name: "Organismes obsèques", desc: "Votre organisme de pompes funèbres et votre contrat obsèques.", icon: "ic_person", destination: AnyView(FuneralOrgIntro())),
    WishCategory(id: 3, name: "Faire-part et annonce", desc: "Vos indications pour le faire-part, désignation du journal presse locale", icon: "ic_news", destination: AnyView(FuneralInviteIntro())),
    WishCategory(id: 4, name: "Don d’organes ou du corps", desc: "Votre choix concernant le don d’organes et le don de votre corps à la science", icon: "ic_organ", destination: AnyView(OrganDonateIntro()))
]

let wishesCeremony = [
    WishCategory(id: 5, name: "Spiritualité et traditions", desc: "Vos indications concernant la spiritualité et les traditions liées de votre cérémonie", icon: "ic_tradition", destination: AnyView(FuneralTraditionsIntro())),
    WishCategory(id: 17, name: "Lieux", desc: "Vos indications sur le lieu de la cérémonie et les différents temps de partage", icon: "ic_location", destination: AnyView(FuneralPlacesIntro())),
    WishCategory(id: 6, name: "Diffusion de la nouvelle", desc: "Liste des personnes susceptibles de relayer la nouvelle.", icon: "ic_people", destination: AnyView(DeathAnnounceIntro())),
    WishCategory(id: 7, name: "Esthétique", desc: "Vos souhaits concernant les fleurs, la décoration et la tenue des invités", icon: "ic_aesthetic", destination: AnyView(FuneralAestheticIntro())),
    WishCategory(id: 8, name: "Musique", desc: "Liste des titres à diffuser lors de votre cérémonie", icon: "ic_music", destination: AnyView(FuneralMusicIntro()))
]

let wishesTransport = [
    WishCategory(id: 9, name: "Vêtements et accessoires", desc: "Liste des vêtements et accessoires que vous souhaitez transmettre", icon: "ic_cloth", destination: AnyView(ClothsDonationIntro())),
    WishCategory(id: 10, name: "Animaux", desc: "Liste des animaux que vous souhaitez transmettre", icon: "ic_animal", destination: AnyView(AnimalDonationIntro())),
    WishCategory(id: 11, name: "Objets", desc: "Liste des objets que vous souhaitez transmettre", icon: "ic_object", destination: AnyView(ObjectsDonationIntro())),
    WishCategory(id: 12, name: "Dons et collectes", desc: "Liste des associations auxquelles vous souhaitez faire un don", icon: "ic_org", destination: AnyView(DonationOrgsIntro()))
]

 let wishesExtras = [
    WishCategory(id: 13, name: "Pièces administratives", desc: "Liste des pièces administratives utiles : Carte d’identité, passeport, carte vitale…", icon: "ic_admin_doc", destination: AnyView(AdminDocsIntro())),
    WishCategory(id: 14, name: "Codes pratiques", desc: "Liste de vos codes pratiques : Ordinateurs, alarmes, digicodes, coffres, cadenas…)", icon: "ic_lock_color_native", destination: AnyView(PracticalCodesIntro())),
    WishCategory(id: 15, name: "Contrats à gérer", desc: "Liste des organismes qui gèrent les contrats liés à votre quotidien (Logement, banque, assurance…)", icon: "ic_wish_contract", destination: AnyView(ManagedContractsIntro())),
    WishCategory(id: 16, name: "Notes complémentaires", desc: "Exprimez-vous librement pour compléter vos volontés", icon: "ic_extra_wish", destination: AnyView(ExtraWishesIntro()))
]

struct WishCategoryCard: View {
    var title: String
    var desc: String
    var icon: String
    var progress: CGFloat = 0.0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30.0)
            .foregroundColor(.white)
            .frame(height: 120)
            .thinShadow()
            .overlay(
                ZStack {
                    HStack(spacing: -10) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30.0)
                                .foregroundColor(progress < 100 ? .gray : .accentColor)
                                .frame(width: 25)
                                .animation(.default, value: progress)
                            if progress < 100 {
                                VStack {
                                    Spacer()
                                    Rectangle()
                                        .foregroundColor(.accentColor)
                                        .frame(width: 25, height: progress)
                                        .clipShape(CustomCorner(corners: [.bottomLeft]))
                                        .animation(.default, value: progress)
                                }
                            }
                        }
                        Rectangle()
                            .foregroundColor(.white)
                            .overlay(
                                VStack {
                                    HStack {
                                        Text(title)
                                            .font(.system(size: 20), weight: .bold)
                                        Spacer()
                                    }
                                    HStack {
                                        Image(icon)
                                            .renderingMode(.template)
                                            .foregroundColor(.accentColor)
                                        Text(desc)
                                            .font(.system(size: 13))
                                            .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                }
                                .padding()
                            )
                        Image(systemName: "chevron.right")
                            .foregroundColor(.accentColor)
                            .padding()
                        Spacer()
                    }
                    
                }
            )
            .padding(.horizontal)
    }
}
