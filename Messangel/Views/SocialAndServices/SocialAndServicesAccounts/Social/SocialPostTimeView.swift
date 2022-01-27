//
//  SocialPostTimeView.swift
//  Messangel
//
//  Created by Saad on 12/22/21.
//

import SwiftUI
import Introspect

struct SocialPostTimeView: View {
    @State private var postTime: Double = 1
    @ObservedObject var vm: OnlineServiceViewModel
    
    var body: some View {
        FlowBaseView(menuTitle: "Ajouter un réseau social", title: "Avant de clôturer, laisser ce message pendant:", valid: .constant(true), destination: AnyView(SocialMemorialAccView(vm: vm))) {
            
            Slider(value: $postTime, in: 1...24)
                .introspectSlider { slider in
                    slider.setThumbImage(UIImage(named: "ic_slider_thumb"), for: .normal)
                }
            Text("\(String(format: "%.f", postTime)) Jour")
        }
        .onChange(of: postTime) { value in
            vm.account.leaveMsgTime = "\(postTime)"
        }
    }
}
