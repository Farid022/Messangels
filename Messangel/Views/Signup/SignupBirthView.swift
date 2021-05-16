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
    var months = ["JAN", "FEB", "MAR", "AVRIL"]
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupPostcodeView()), footer: AnyView(Text("Vous devez être majeur pour créer votre compte Messangel"))) {
            Text("Je suis né(e) le…")
                .font(.headline)
            HStack {
                Spacer().frame(width: 20)
                Picker(selection: $dob_day, label: HStack(alignment: .bottom) {
                    Image("updown")
                    Text("\(dob_day)").font(.system(size: 20))
                }) {
                    ForEach((1...31), id: \.self) {
                        Text("\($0)")
                    }
                }
                Spacer()
                Picker(selection: $dob_month, label: HStack(alignment: .bottom) {
                    Image("updown")
                    Text("\(dob_month)").font(.system(size: 20))
                }) {
                    ForEach(months, id: \.self) {
                        Text("\($0)")
                    }
                }
                Spacer()
                Picker(selection: $dob_year, label: HStack(alignment: .bottom) {
                    Image("updown")
                    Text(String(dob_year)).font(.system(size: 20))
                }) {
                    ForEach((1960...2001), id: \.self) {
                        Text(String($0))
                    }
                }
                Spacer().frame(width: 20)
            }.padding().background(Color.white).cornerRadius(20).foregroundColor(.black)
            Text("Dans la ville de…")
                .font(.headline)
            TextField("Ville", text: $city, onCommit:  {
                valid = true
            })
        }
        .pickerStyle(MenuPickerStyle())
    }
}

struct SignupBirthView_Previews: PreviewProvider {
    static var previews: some View {
        SignupBirthView()
    }
}
