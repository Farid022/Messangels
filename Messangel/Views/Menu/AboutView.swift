//
//  AboutView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        MenuBaseView(title: "À propos de Messangel") {
            HStack {
                Text("Messangel")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.bottom)
                Spacer()
            }
            Text("""
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.
                
                At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.

                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum
""")
                .font(.system(size: 13))
                .multilineTextAlignment(.leading)
                .padding(.bottom)
            Button("Messangel.com") {
                
            }
            .buttonStyle(MyButtonStyle(foregroundColor: .black))
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .padding(.bottom)
            HStack {
                Text("Communauté Messangel")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
