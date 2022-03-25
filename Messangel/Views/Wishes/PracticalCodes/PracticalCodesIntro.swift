//
//  AdminDocs.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct PracticalCodesIntro: View {
    @StateObject private var vm = PracticalCodeViewModel()
    @State private var gotList = false
    @EnvironmentObject private var navigationModel: NavigationModel
    
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
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
                    Text("Codes pratiques")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Listez vos codes pratiques : Ordinateurs, alarmes, digicodes, coffres, cadenas…")
                        .font(.system(size: 15))
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(isCustomAction: true, customAction: {
                            navigationModel.pushContent(String(describing: Self.self)) {
                                if vm.practicalCodes.isEmpty {
                                    PracticalCodeNew(vm: vm)
                                } else {
                                    PracticalCodesList(vm: vm, refresh: false)
                                }
                            }
                        }, active: .constant(gotList))
                            .animation(.default, value: gotList)
                    }
                }.padding()
            }
            .foregroundColor(.white)
        }
        .onDidAppear {
            vm.getPracticalCodes { _ in
                gotList.toggle()
            }
        }
    }
}
