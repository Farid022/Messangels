//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralPlaceSelection: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var showNote = false
    @ObservedObject var vm: FuneralLocationViewModel
    private let title = "Indiquez le lieu de cérémonie"
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.location.bury_location_note.bound)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(stepNumber: 2.0, totalSteps: 6.0, noteText: $vm.location.bury_location_note.bound, note: true, showNote: $showNote, menuTitle: "Lieux", title: title, valid: .constant(!vm.name.isEmpty), destination: AnyView(FuneralRestingPlace(vm: vm))) {
                if vm.name.isEmpty {
                    HStack {
                        Button(action: {
                            navigationModel.presentContent(title) {
                                FuneralPlacesList(vm: vm)
                            }
                        }, label: {
                            ZStack {
                                Capsule()
                                    .foregroundColor(.accentColor)
                                    .frame(width: 200, height: 56)
                                HStack {
                                    Image("ic_location")
                                        .renderingMode(.template)
                                        .foregroundColor(.white)
                                    Text("Liste des lieux")
                                        .foregroundColor(.white)
                                }
                            }
                            
                        })
                        Spacer()
                    }
                } else {
                    HStack {
                        FuneralCapsuleView(name: vm.name) {
                            vm.location.bury_location = nil
                            vm.name = ""
                        }
                        Spacer()
                    }
                }
            }
            
        }
    }
}
