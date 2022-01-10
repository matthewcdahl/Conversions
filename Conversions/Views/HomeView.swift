//
//  ContentView.swift
//  Conversions
//
//  Created by Matt Dahl on 1/9/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            NavigationLink(destination: {
                FormulaView(category: "pricing")
            }, label: {
                Text("Go to formula view")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
