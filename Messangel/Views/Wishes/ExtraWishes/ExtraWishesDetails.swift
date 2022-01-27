//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct ExtraWishesDetails: View {
    @State private var showNote = false
    @State private var loading = false
    @EnvironmentObject var navModel: NavigationModel
    @StateObject private var vm = ExtraWishViewModel()
    var title = "Exprimez-vous librement sur vos volontés"
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.extraWish.express_yourself_note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: {
                loading.toggle()
                vm.create() { success in
                    loading.toggle()
                    if success {
                        UserDefaults.standard.set(100.0, forKey: wishesExtras.last!.id)
                        navModel.pushContent(title) {
                            FuneralDoneView()
                        }
                    }
                }
            },note: false, showNote: .constant(false), menuTitle: wishesExtras.last!.id, title: title, valid: .constant(true)) {
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
