//
//  ContentView.swift
//  Conversions
//
//  Created by Matt Dahl on 1/9/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: FunctionModel
    @State var pressed = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    
                    //Text("Home")
                        //.font(.largeTitle)
                    Text("Create Custom Conversions")
                        .font(.title2)
                        .padding(.bottom, 70)
                        .padding(.horizontal)
                    
                    
                    
                        VStack(spacing: 40){
                        
                            HStack(spacing: 40){
                                NavigationLink(destination: FormulaView(category: "metric", currentFunction: 0, currentExpression: 0, selectedWheelIndex: 0, fromFavorites: false),
                                label: {
                                    HomeCardView(image: "metric", labelTop: "METRIC", labelBottom: "")
                                })
                                
                                NavigationLink (destination: FormulaView(category: "pricing", currentFunction: 0, currentExpression: 0, selectedWheelIndex: 0, fromFavorites: false),
                                label: {
                                        HomeCardView(image: "pricing", labelTop: "PRICING", labelBottom: "")
                                })
                                
                                
                                
                            }
                            HStack(spacing: 40){
                                NavigationLink(destination: FormulaView(category: "diameter", currentFunction: 0, currentExpression: 0, selectedWheelIndex: 0, fromFavorites: false),
                                label: {
                                    HomeCardView(image: "roll", labelTop: "ROLL", labelBottom: "DIAMETER")
                                })
                               
                                NavigationLink(destination: FormulaView(category: "measure", currentFunction: 0, currentExpression: 0, selectedWheelIndex: 0, fromFavorites: false),
                                label: {
                                    HomeCardView(image: "measure", labelTop: "UNITS OF", labelBottom: "MEASURE")
                                })
                                
                            }
                        
                    }
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 40)
                .navigationTitle("Home")
            }
            //.background(.black)
        }
    }
}



struct HomeCardView: View{
    
    @Environment(\.colorScheme) var colorScheme
    
    var image: String
    var labelTop: String
    var labelBottom: String
    
    var body: some View{
        
        if(colorScheme == .light){
            ZStack{
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.2), radius: 10, x: 0, y:0)
                    //.frame(height: 200)
                VStack(spacing: 0){
                    Spacer()
                    Image(image + "-black")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(width: 90, height: 90, alignment: .center)
                    Spacer()
                    Text(labelTop)
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(labelBottom)
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                }
            }
        }
        else{
            ZStack{
                Rectangle()
                    .foregroundColor(Color(.sRGB, red: 0.15, green: 0.15, blue: 0.15, opacity: 1))
                    .cornerRadius(10)
                    .shadow(color: Color(.sRGB, red: 0.5, green: 0.5, blue: 0.5, opacity: 0.35), radius: 20, x: 0, y:4)
                    //.frame(height: 200)
                VStack(spacing: 0){
                    Spacer()
                    Image(image + "-white")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(width: 90, height: 90, alignment: .center)
                    Spacer()
                    Text(labelTop)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(labelBottom)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(FunctionModel())
    }
}
