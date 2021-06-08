//
//  SignupBirthView.swift
//  Messengel
//
//  Created by Saad on 5/6/21.
//

import SwiftUI

struct SignupBirthView: View {
    @State private var dob_day = 1
    @State private var dob_month = "AVRIL"
    @State private var dob_year = 2001
    @State private var city: String = ""
    @State private var progress = 12.5
    @State private var valid = false
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupPostcodeView()), currentView: "SignupBirthView", footer: AnyView(Text("Vous devez être majeur pour créer votre compte Messangel").font(.system(size: 13)))) {
            Text("Je suis né(e) le…")
                .font(.system(size: 22))
                .fontWeight(.bold)
            MyDatePickerView(day: $dob_day, month: $dob_month, year: $dob_year)
            Text("Dans la ville de…")
                .font(.system(size: 22))
                .fontWeight(.bold)
            TextField("Ville", text: $city, onCommit:  {
                valid = true
            })
        }
    }
}

struct SignupBirthView_Previews: PreviewProvider {
    static var previews: some View {
        SignupBirthView()
    }
}
