//
//  LaunchTabView.swift
//  Conversions
//
//  Created by Matt Dahl on 1/11/22.
//

import SwiftUI

struct LaunchTabView: View {
    
    @EnvironmentObject var model: FunctionModel
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView()
                .tabItem{
                    VStack{
                        Image(systemName: "3.circle.fill")
                        Text("Conversion")
                    }
                }
                .tag(0)
            
            FavoritesView()
                .tabItem{
                    VStack{
                        Image(systemName: "star.fill")
                        Text("Favorites")
                    }
                }
                .tag(1)
        }
        .onChange(of: selectedTab, perform: {newValue in
            print("Change tabs")
        })
    }
}

struct LaunchTabView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchTabView()
            .environmentObject(FunctionModel())
    }
}
