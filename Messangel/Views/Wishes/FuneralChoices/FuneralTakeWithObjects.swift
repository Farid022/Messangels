//
//  FuneralTakeWithObjects.swift
//  Messangel
//
//  Created by Saad on 10/20/21.
//

import SwiftUI
import NavigationStack

struct FuneralTakeWithObjects: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: FeneralViewModel
    @EnvironmentObject var navModel: NavigationModel
    var title = "Indiquez si vous souhaitez emporter des objets ou accessoires"
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.funeral.acessories_note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: {
                loading.toggle()
                UserDefaults.standard.set(100.0, forKey: wishesPersonal.first!.id)
                vm.create() { success in
                    loading.toggle()
                    if success {
                        navModel.pushContent(title) {
                            FuneralDoneView()
                        }
                    }
                }
            },note: false, showNote: .constant(false), menuTitle: wishesPersonal.first!.id, title: title, valid: .constant(true)) {
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
