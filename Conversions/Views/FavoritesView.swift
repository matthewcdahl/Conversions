//
//  FavoritesView.swift
//  Conversions
//
//  Created by Matt Dahl on 1/11/22.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject var model: FunctionModel
    
    var body: some View {
        List(model.favorites){ fav in
            Text(fav.solutionValue)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FunctionModel())
    }
}
