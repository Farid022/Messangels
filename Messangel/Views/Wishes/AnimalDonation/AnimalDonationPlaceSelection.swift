//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct AnimalDonationPlaceSelection: View {
    var donationTypes = [ClothsDonationPlace.contact, ClothsDonationPlace.organization]
    @State private var selectedDonation = ClothsDonationPlace.none
    @ObservedObject var vm: AnimalDonatiopnViewModel

    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 6.0, totalSteps: 8.0, menuTitle: "ANIMAUX", title: "\(vm.animalDonation.animal_name) - À qui confier \(vm.animalDonation.single_animal! ? "votre animal?" : "vos animaux?")", valid: .constant(selectedDonation != .none), destination: selectedDonation == .organization ? AnyView(AnimalDonationOrganization(vm: vm)) : AnyView(AnimalDonationContact(vm: vm))) {
                HStack {
                    ForEach(donationTypes, id: \.self) { type in
                        ChoiceCard(text: type == .contact ? "Un contact" : "Un organisme", selected: .constant(selectedDonation == type))
                            .onTapGesture {
                                selectedDonation = type
                            }
                    }
                }
            }
        }
        .onDidAppear {
            if vm.animalDonation.animal_contact_detail != nil {
                selectedDonation = .contact
            } else if vm.animalDonation.animal_organization_detail != nil {
                selectedDonation = .organization
            }
        }
    }
}
