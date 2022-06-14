//
//  SwiftUIView.swift
//  Messangel
//
//  Created by Saad on 6/8/22.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.system(size: 13.0))
            
            Spacer()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
