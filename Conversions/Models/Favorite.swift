//
//  File.swift
//  Conversions
//
//  Created by Matt Dahl on 1/11/22.
//

import Foundation

class Favorite: Identifiable, Codable{
    
    var id: UUID
    var title: String
    var inputs: [String]
    var inputValues: [Double]
    var solution: String
    var solutionValue: String
    var category: String
    var functionIndex: Int
    var expressionIndex: Int
    var wheelIndex: Int
    
    init(id: UUID, title: String, inputs: [String], inputValues: [Double], solution: String, solutionValue: String, category: String, functionIndex: Int, expressionIndex: Int, wheelIndex: Int){
        self.id = id
        self.title = title
        self.inputs = inputs
        self.inputValues = inputValues
        self.solution = solution
        self.solutionValue = solutionValue
        self.category = category
        self.functionIndex = functionIndex
        self.expressionIndex = expressionIndex
        self.wheelIndex = wheelIndex
    }
    
}
