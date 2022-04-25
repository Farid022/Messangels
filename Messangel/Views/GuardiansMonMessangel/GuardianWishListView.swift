//
//  WishListView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/14/22.
//

import SwiftUI

struct GuardianWishListView: View {
    @State private var showExitAlert = false
    @StateObject private var guardianMonMessangelViewModel = GuardianMonMessangelViewModel()
    @StateObject private var wishesListViewModel = WishesListViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GuardianWishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
    }
}
