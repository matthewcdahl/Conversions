//
//  FunctionModel.swift
//  Conversions
//
//  Created by Matt Dahl on 1/10/22.
//

import Foundation

class FunctionModel: ObservableObject{
    
    @Published var functions = [Function]()
    var inputs = [Double?]()
    @Published var lastCategory = ""
    
    @Published var favorites = [Favorite](){
        didSet{
            saveFavorites()
        }
    }
    let favoritesKey: String = "favorites_list"
    
    
    init(){
        self.functions = DataService.getLocalData()
        inputs.append(nil)
        inputs.append(nil)
        inputs.append(nil)
        
        //TODO: Get favorites from user defaults
        
        guard
            let data = UserDefaults.standard.data(forKey: favoritesKey),
            let favoriteItems = try? JSONDecoder().decode([Favorite].self, from: data)
        else {
            return
        }
        
        self.favorites = favoriteItems
        
        
    }
    
    func intToString(_ integer: Int) -> String{
        if(integer == 0){
            return "Zero"
        } else if(integer == 1){
            return "One"
        } else if(integer == 2){
            return "Two"
        } else if(integer == 3){
            return "Three"
        } else if(integer == 4){
            return "Four"
        } else if(integer == 5){
            return "Five"
        }
        return String(integer)
    }
    
    
    func getFunctionsForCategory(category: String) -> [Function]{
        var rtn = [Function]()
        for f in functions{
            if(f.category == category){
                rtn.append(f)
            }
        }
        
        return rtn
    }
    
    
    func getSolutionsFromFunctions(arr: [Function]) -> [String]{
        var rtn =  [String]()
        for f in arr{
            rtn.append(f.solution)
        }
        return rtn
    }
    
    func getFirstInputsFromFunction(function: Function) -> [String]{
        
        var rtn = [String]()
        
        for i in function.expressions{
            rtn.append(i.inputs[0])
        }
        
        return rtn
    }
    
    func addInput(toAdd: Double?, index: Int){
        inputs[index] = toAdd
    }
    
    func resetInputs(){
        inputs.removeAll()
        inputs.append(nil)
        inputs.append(nil)
        inputs.append(nil)
        
    }
    
    func solveFunction(functionIndex: Int, expressionIndex: Int, availableFuncs: [Function]) -> String{
        
        if(availableFuncs.count <= 0){
            return ""
        }
        let eq = availableFuncs[functionIndex].expressions[expressionIndex].expression
        let inputNumber = availableFuncs[functionIndex].expressions[expressionIndex].inputs.count
        var actualNumber = 0
        
        for i in inputs{
            if(i != nil){
                actualNumber += 1
            }
        }
        
        if(actualNumber < inputNumber){
            return ""
        }
        
        var filledInEq: String = ""
        
        if(inputs[0] != nil){
            filledInEq = eq.replacingOccurrences(of: "A", with: String(inputs[0]!))
        }
        if(inputs[1] != nil){
            filledInEq = filledInEq.replacingOccurrences(of: "B", with: String(inputs[1]!))
        }
        if(inputs[2] != nil){
            filledInEq = filledInEq.replacingOccurrences(of: "C", with: String(inputs[2]!))
        }
        
        
        let expression = NSExpression(format:filledInEq)
        print(expression)
        let value: Double = expression.expressionValue(with: nil, context: nil) as! Double
        
        return String(round(value*10000) / 10000)
    }
    
    func addToFavorites(newFav: Favorite){
        
        favorites.append(newFav)
        
        
    }
    
    func removeFromFavorites(toRemoveId: UUID){
        for i in 0..<favorites.count{
            if favorites[i].id == toRemoveId{
                favorites.remove(at: i)
                return
            }
        }
        
        
    }
    
    func saveFavorites(){
        //TODO: save favorites array to user defaults
        
        if let encodedData = try? JSONEncoder().encode(favorites){
            
            UserDefaults.standard.set(encodedData, forKey: favoritesKey)
            
        }
    }
    
    func getValidInputs() -> [Double]{
        var rtn = [Double]()
        for i in inputs{
            if(i != nil){
                rtn.append(i!)
            }
        }
        
        return rtn
    }
    
    func setInputsFromFavorite(favInputs: [Double]){
        
        resetInputs()
        
        for i in 0..<favInputs.count{
            self.inputs[i] = favInputs[i]
        }
        
    }
    
    func getFavoritesForCategory(category: String) -> [Favorite]{
        
        var rtn = [Favorite]()
        
        for f in favorites{
            if(f.category == category){
                rtn.append(f)
            }
        }
        return rtn
    }
    
    func updateFavoritesAfterDelete(diameter: [Favorite], pricing: [Favorite], metric: [Favorite], measure: [Favorite]) {
        self.favorites.removeAll()
        self.favorites += diameter
        self.favorites += pricing
        self.favorites += metric
        self.favorites += measure
    }
    
        
    
}
