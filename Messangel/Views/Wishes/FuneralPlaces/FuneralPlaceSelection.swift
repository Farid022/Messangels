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
    @State private var note = ""
    @ObservedObject var vm: FuneralLocationViewModel
    private let title = "Indiquez le lieu de cérémonie"
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Lieux", title: title, valid: .constant(!vm.name.isEmpty), destination: AnyView(FuneralRestingPlace(vm: vm))) {
                if vm.name.isEmpty {
                    Button(action: {
                        navigationModel.presentContent(title) {
                            FuneralPlacesList(vm: vm)
                        }
                    }, label: {
                        Image("list_org")
                    })
                } else {
                    FuneralCapsuleView(name: vm.name) {
                        vm.location.bury_location = nil
                        vm.name = ""
                    }
                }
            }
            
        }
    }
}
