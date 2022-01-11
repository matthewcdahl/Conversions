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
        //ListCardView(favorite: Favorite(id: UUID(), title: "Here is a formula", inputs: ["MSF", "$/MSI"], inputValues: [0.54, 34.4444], solution: "Linear Feet", solutionValue: "23.445"))
        NavigationView{
            List(){
                
                ForEach(model.favorites){fav in
                    NavigationLink(destination: {
                        FormulaView(category: fav.category, currentFunction: fav.functionIndex, currentExpression: fav.expressionIndex, selectedWheelIndex: fav.wheelIndex)
                            .onAppear(perform: {
                                model.setInputsFromFavorite(favInputs: fav.inputValues)
                            })
                    }, label: {
                        ListCardView(favorite: Favorite(id: fav.id, title: fav.title, inputs: fav.inputs, inputValues: fav.inputValues, solution: fav.solution, solutionValue: fav.solutionValue, category: fav.category, functionIndex: fav.functionIndex, expressionIndex: fav.expressionIndex, wheelIndex: fav.wheelIndex))

                    })
                }
                .onDelete(perform: {indexSet in
                    model.favorites.remove(atOffsets: indexSet)
                })
                
            }
            .navigationTitle("Favorites")
            .toolbar(content: {
                EditButton()
            })
        }
    }
}


struct ListCardView: View{
    
    var favorite: Favorite
    
    var body: some View{
        VStack(alignment: .leading){
            Text(favorite.title)
                .font(.headline)
            HStack(spacing: 30){
                ForEach(0..<favorite.inputs.count, id: \.self){i in
                    VStack(alignment: .leading){
                        Text(favorite.inputs[i])
                            .font(.caption)
                        if(favorite.inputValues.count > i){
                            Text(String(favorite.inputValues[i]))
                                .font(.caption)
                        } else{
                            Text("--")
                        }
                    }
                }
                
                
                VStack(alignment: .leading){
                    Text(favorite.solution)
                        .bold()
                        .font(.caption)
                    if(favorite.solutionValue == nil || favorite.solutionValue == ""){
                        Text("--")
                    }
                    else{
                        Text(favorite.solutionValue)
                            .bold()
                            .font(.caption)
                    }
                }
                
            }
            
        }
    }
    
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FunctionModel())
    }
}
