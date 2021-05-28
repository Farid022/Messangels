//
//  GuardianFormView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI

struct GuardianFormIntroView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.accentColor
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Spacer()
                Text("Ajouter un Ange-gardien")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .padding(.bottom)
                Text("""
                    Indiquez les coordonnées d’une personne à qui vous confierez votre Messangel.

                    Cette personne devra accepter votre demande par mail.
                    """)
                    .font(.system(size: 15))
//                    .offset(x:offset)
//                    .onAppear{
//                        DispatchQueue.main.async {
//                            withAnimation {
//                                offset = 0.0
//                            }
//                        }
//                    }
               
                Spacer()
                HStack {
                    Spacer()
                    NextButton(destination: AnyView(GuardianFormLastNameView()), active: .constant(true))
                }
            }.padding()
        }
        .foregroundColor(.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward").foregroundColor(.white)
        })
    }
}

struct GuardianFormView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianFormIntroView()
    }
}
