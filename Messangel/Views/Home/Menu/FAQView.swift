//
//  FAQView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI

struct FAQView: View {
    var body: some View {
        MenuBaseView(title: "Support F.A.Q.") {
            Text("Lien intégré vers www.messangel.com")
                .fontWeight(.bold)
                .frame(height: UIScreen.main.bounds.midY)
        }
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FAQView()
        }
    }
}
