//
//  ShoppingListView.swift
//  TastyRecipes
//
//  Created by crystal on 8/12/24.
//

import SwiftUI

struct ShoppingListView: View {
    var body: some View {
        NavigationView {
            Text("Shopping List")
                .navigationTitle("Shopping List")
        }
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
