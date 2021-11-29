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
    
    var body: some View {
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
                        WishCategoryCard(title: wish.id, desc: wish.desc, icon: wish.icon)
                            .onTapGesture {
                                navigationModel.pushContent(TabBarView.id) {
                                    wish.destination
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
                    WishCategoryCard(title: wish.id, desc: wish.desc, icon: wish.icon)
                        .onTapGesture {
                            navigationModel.pushContent(TabBarView.id) {
                                wish.destination
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
                    WishCategoryCard(title: wish.id, desc: wish.desc, icon: wish.icon)
                        .onTapGesture {
                            navigationModel.pushContent(TabBarView.id) {
                                wish.destination
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
                    WishCategoryCard(title: wish.id, desc: wish.desc, icon: wish.icon)
                        .onTapGesture {
                            navigationModel.pushContent(TabBarView.id) {
                                wish.destination
                            }
                        }
                }
            }
            .padding()
            Spacer().height(70)
        }
    }
}

struct WishCategory: Identifiable {
    var id: String
    var desc: String
    var icon: String
    var destination: AnyView
}

private let wishesPersonal = [
    WishCategory(id: "Choix funéraires", desc: "Spiritualité et traditions au sein de votre cérémonie.", icon: "ic_funeral", destination: AnyView(FuneralChoiceIntro())),
    WishCategory(id: "Organismes spécialisés", desc: "Votre organisme de pompes funèbres et votre contrat obsèques.", icon: "ic_person", destination: AnyView(FuneralOrgIntro())),
    WishCategory(id: "Faire-part et annonce", desc: "Vos indications pour le faire-part, désignation du journal presse locale", icon: "ic_news", destination: AnyView(FuneralInviteIntro())),
    WishCategory(id: "Don d’organes ou du corps", desc: "Votre choix concernant le don d’organes et le don de votre corps à la science", icon: "ic_organ", destination: AnyView(OrganDonateIntro()))
]

private let wishesCeremony = [
    WishCategory(id: "Spiritualité et traditions", desc: "Vos indications concernant la spiritualité et les traditions liées de votre cérémonie", icon: "ic_tradition", destination: AnyView(FuneralTraditionsIntro())),
    WishCategory(id: "Lieux", desc: "Vos indications sur le lieu de la cérémonie et les différents temps de partage", icon: "ic_location", destination: AnyView(FuneralPlacesIntro())),
    WishCategory(id: "Diffusion de la nouvelle", desc: "Liste des personnes susceptibles de relayer la nouvelle.", icon: "ic_people", destination: AnyView(DeathAnnounceIntro())),
    WishCategory(id: "Esthétique", desc: "Vos souhaits concernant les fleurs, la décoration et la tenue des invités", icon: "ic_aesthetic", destination: AnyView(FuneralAestheticIntro())),
    WishCategory(id: "Musique", desc: "Liste des titres à diffuser lors de votre cérémonie", icon: "ic_music", destination: AnyView(FuneralMusicIntro()))
]

private let wishesTransport = [
    WishCategory(id: "Vêtements et accessoires", desc: "Liste des vêtements et accessoires que vous souhaitez transmettre", icon: "ic_organ", destination: AnyView(ClothsDonationIntro())),
    WishCategory(id: "Animaux", desc: "Liste des animaux que vous souhaitez transmettre", icon: "ic_organ", destination: AnyView(AnimalDonationIntro())),
    WishCategory(id: "Objets", desc: "Liste des objets que vous souhaitez transmettre", icon: "ic_organ", destination: AnyView(ObjectsDonationIntro())),
    WishCategory(id: "Dons", desc: "Liste des associations auxquelles vous souhaitez faire un don", icon: "ic_organ", destination: AnyView(DonationOrgsIntro()))
]

private let wishesExtras = [
    WishCategory(id: "Pièces administratives", desc: "Liste des pièces administratives utiles : Carte d’identité, passeport, carte vitale…", icon: "ic_doc", destination: AnyView(AdminDocsIntro())),
    WishCategory(id: "Codes pratiques", desc: "Liste de vos codes pratiques : Ordinateurs, alarmes, digicodes, coffres, cadenas…)", icon: "ic_lock_color_native", destination: AnyView(PracticalCodesIntro())),
    WishCategory(id: "Contrats à gérer", desc: "Liste des organismes qui gèrent les contrats liés à votre quotidien (Logement, banque, assurance…)", icon: "ic_contract", destination: AnyView(ManagedContractsIntro())),
    WishCategory(id: "Expression libre", desc: "Exprimez-vous librement pour compléter vos volontés", icon: "ic_organ", destination: AnyView(ExtraWishesIntro()))
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
                                .foregroundColor(.gray)
                                .frame(width: 25)
                            VStack {
                                Spacer()
                                Rectangle()
                                    .foregroundColor(.accentColor)
                                    .frame(width: 25, height: progress)
                                    .clipShape(CustomCorner(corners: [.bottomLeft]))
                            }
                        }
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 300)
                            .overlay(
                                VStack {
                                    HStack {
                                        Text(title)
                                            .font(.system(size: 20), weight: .bold)
                                        Spacer()
                                    }
                                    HStack {
                                        Image(icon)
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
