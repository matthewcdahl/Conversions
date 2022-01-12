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
            
            if model.favorites.count > 0{
                List(){
                    
                    var pricingFavorites = model.getFavoritesForCategory(category: "pricing")
                    var metricFavorites = model.getFavoritesForCategory(category: "metric")
                    var diameterFavorites = model.getFavoritesForCategory(category: "diameter")
                    var measureFavorites = model.getFavoritesForCategory(category: "measure")
                    
                    //MARK: PRICING
                    if(pricingFavorites.count > 0){
                        Section(header: Text("Pricing")) {
                            ForEach(pricingFavorites){fav in
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
                                pricingFavorites.remove(atOffsets: indexSet)
                                model.updateFavoritesAfterDelete(diameter: diameterFavorites, pricing: pricingFavorites, metric: metricFavorites, measure: measureFavorites)
                            })
                        }
                    }
                    
                    //MARK: Metric
                    if(metricFavorites.count > 0){
                        Section(header: Text("Metric")) {
                            ForEach(metricFavorites){fav in
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
                                metricFavorites.remove(atOffsets: indexSet)
                                model.updateFavoritesAfterDelete(diameter: diameterFavorites, pricing: pricingFavorites, metric: metricFavorites, measure: measureFavorites)
                            })
                        }
                    }
                    
                    //MARK: Diameter
                    if(diameterFavorites.count > 0){
                        Section(header: Text("Roll Diameter")) {
                            ForEach(diameterFavorites){fav in
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
                                diameterFavorites.remove(atOffsets: indexSet)
                                model.updateFavoritesAfterDelete(diameter: diameterFavorites, pricing: pricingFavorites, metric: metricFavorites, measure: measureFavorites)
                            })
                        }
                    }
                    
                    //MARK: Measure
                    if(measureFavorites.count > 0){
                        Section(header: Text("Units of Measure")) {
                            ForEach(measureFavorites){fav in
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
                                measureFavorites.remove(atOffsets: indexSet)
                                model.updateFavoritesAfterDelete(diameter: diameterFavorites, pricing: pricingFavorites, metric: metricFavorites, measure: measureFavorites)
                            })
                        }
                    }
                    
                }
                .navigationTitle("Favorites")
                .toolbar(content: {
                    EditButton()
                })
            }
            else{
                VStack{
                    Text("Add favorites by")
                    HStack{
                        Text("clicking")
                        Image(systemName: "plus.circle")
                            .foregroundColor(.blue)
                        Text("on a formula")
                    }
                }
                .navigationTitle("Favorites")
            }
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
