//
//  Expression.swift
//  Conversions
//
//  Created by Matt Dahl on 1/10/22.
//

import Foundation

class Expression: Identifiable, Decodable{
    
    var id: UUID?
    var inputs: [String]
    var expression: String
    
}
