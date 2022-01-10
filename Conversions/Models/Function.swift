//
//  Function.swift
//  Conversions
//
//  Created by Matt Dahl on 1/10/22.
//

import Foundation

class Function: Identifiable, Decodable{
    
    var id: UUID?
    var solution: String
    var expressions: [Expression]
    var category: String
    
}
