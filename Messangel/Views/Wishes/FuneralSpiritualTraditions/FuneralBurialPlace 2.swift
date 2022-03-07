//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralBurialPlace: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: FuneralSpritualityViewModel
    @EnvironmentObject var navModel: NavigationModel
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.sprituality.ceremony_note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: {
                loading.toggle()
                vm.createSprituality() { success in
                    loading.toggle()
                    if success {
                        navModel.pushContent("Indiquez si vous souhaitez emporter des objets ou accessoires") {
                            FuneralDoneView()
                        }
                    }
                }
            },note: false, showNote: .constant(false), menuTitle: "Spiritualité et traditions", title: "Indiquez le lieu d’inhumation (cimetière précis, caveau familial…)", valid: .constant(true)) {
                VStack(spacing: 0.0) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 161, height: 207.52)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.gray)
                                .frame(width: 56, height: 56)
                                .overlay(
                                    Button(action: {
                                        showNote.toggle()
                                    }) {
                                        Image("ic_add_note")
                                    }
                                )
                        )
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 161, height: 44)
                        .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
                        .overlay(Text("Note"))
                    if loading {
                        Loader()
                            .padding(.top)
                    }
                }
                .thinShadow()
            }
        }
    }
}
