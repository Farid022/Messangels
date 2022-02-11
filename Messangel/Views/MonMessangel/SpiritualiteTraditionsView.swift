//
//  SpiritualiteTraditionsView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/9/22.
//

import SwiftUI
import NavigationStack
import Combine
struct SpiritualiteTraditionsView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text("Spiritualité et traditions")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                           
                        Spacer()
                       
                       
                    }
                    .padding(.trailing)
                    .padding(.leading))
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                    ScrollView {
                        VStack{
                            
                            Text("Voici mes volontés concernant la spiritualité et les traditions au sein de ma cérémonie")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.horizontal)
                            
                            Group
                            {
                                FunerairesView(title: "Je souhaite une cérémonie non-religieuse", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ")
                                    .padding(.bottom,40)
                                FunerairesView(title: "Je souhaite une cérémonie religieuse ou philosophique", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ")
                                    .padding(.bottom,40)
                                
                                FunerairesView(title: "Je souhaite faire appliquer des traditions", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam etjusto duo dolores et ea rebum. ")
                                    .padding(.bottom,40)
                        }
                    }
                    }
                }
            }
        }
    }
}

struct SpiritualiteTraditionsView_Previews: PreviewProvider {
    static var previews: some View {
        SpiritualiteTraditionsView()
    }
}
