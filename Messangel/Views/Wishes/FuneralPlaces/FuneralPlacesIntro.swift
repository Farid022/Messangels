//
//  FuneralChoiceIntro.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralPlacesIntro: View {
    @StateObject private var vm = FuneralLocationViewModel()

    var body: some View {
        NavigationStackView("FuneralPlacesIntro") {
            ZStack(alignment: .topLeading) {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    BackButton(icon:"xmark")
                    Spacer()
                    HStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 56, height: 56)
                            .cornerRadius(25)
                            .normalShadow()
                            .overlay(Image("info"))
                        Spacer()
                    }
                    .padding(.bottom)
                    Text("Lieux")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Indiquez les lieux concernant les différents temps : lieu de repos, cérémonie, retrouvailles, trajet de convoi. Vous pouvez aussi préciser si une organisation particulière est à prévoir (trajet long, transfert, plusieurs lieux de cérémonie…).")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(source: "FuneralPlacesIntro", destination: AnyView(FuneralPlaceType(vm: vm)), active: .constant(true))
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
        .onDidAppear {
            vm.get { sucess in
                if sucess {
                    if vm.locations.count > 0 {
                        let i = vm.locations[0]
                        vm.location = FuneralLocation(location_of_ceremony: i.location_of_ceremony, location_of_ceremony_note: i.location_of_ceremony_note, route_convey_note: i.route_convey_note, reunion_location_note: i.reunion_location_note, special_ceremony_note: i.special_ceremony_note, bury_location: i.bury_location?.id, bury_location_note: i.bury_location_note, resting_place: i.resting_place?.id, resting_place_note: i.resting_place_note)
                        if let place = i.bury_location {
                            vm.name = place.name
                        }
                        vm.updateRecord = true
                    }
                }
            }
        }
    }
}
