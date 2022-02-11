//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralPlaceName: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @State private var selectedPlace = BuryLocation(id: 0, name: "")
    @ObservedObject var vm: FuneralLocationViewModel
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Lieux", title: "Indiquez le lieu de cérémonie", valid: .constant(!selectedPlace.name.isEmpty), destination: AnyView(FuneralRestingPlace(vm: vm))) {
                if selectedPlace.name.isEmpty {
                    Button(action: {
                        navigationModel.presentContent("Indiquez le lieu de cérémonie") {
                            FuneralPlacesList(selectedPlace: $selectedPlace, vm: vm)
                        }
                    }, label: {
                        Image("list_org")
                    })
                } else {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(height: 56)
                        .foregroundColor(.white)
                        .thinShadow()
                        .overlay(HStack {
                            Text(selectedPlace.name)
                                .font(.system(size: 14))
                            Button(action: {
//                                selectedCompany.removeAll()
                            }, label: {
                                Image("ic_btn_remove")
                            })
                        })
                }
            }
            
        }
    }
}
