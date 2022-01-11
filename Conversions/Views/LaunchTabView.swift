//
//  LaunchTabView.swift
//  Conversions
//
//  Created by Matt Dahl on 1/11/22.
//

import SwiftUI

struct LaunchTabView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView()
                .tabItem{
                    Image(systemName: "3.circle.fill")
                    Text("Conversion")
                }
                .tag(0)
            
            FavoritesView()
                .tabItem{
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
                .tag(1)
        }
    }
}

struct LaunchTabView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchTabView()
            .environmentObject(FunctionModel())
    }
}
