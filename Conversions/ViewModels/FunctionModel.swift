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
    
    
    init(){
        self.functions = DataService.getLocalData()
        inputs.append(nil)
        inputs.append(nil)
        inputs.append(nil)
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
    }
    
    func solveFunction(functionIndex: Int, expressionIndex: Int) -> String{
        
        let eq = functions[functionIndex].expressions[expressionIndex].expression
        let inputNumber = functions[functionIndex].expressions[expressionIndex].inputs.count
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
        
    
}
