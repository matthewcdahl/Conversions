//
//  ContentView.swift
//  Conversions
//
//  Created by Matt Dahl on 1/9/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: FunctionModel
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: {
                    FormulaView(category: "pricing")
                        .onAppear(perform: {
                            model.resetInputs()
                        })
                }, label: {
                    Text("Go to formula view")
                })
                
                NavigationLink(destination: {
                    FormulaView(category: "diameter")
                        .onAppear(perform: {
                            model.resetInputs()
                        })
                }, label: {
                    Text("Go to roll diameter view")
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
