//
//  DataService.swift
//  Conversions
//
//  Created by Matt Dahl on 1/10/22.
//

import Foundation

class DataService{
    
    static func getLocalData() ->[Function]{
        
        let pathString = Bundle.main.path(forResource: "functions", ofType: "json")
        
        guard pathString != nil else{
            return [Function]()
        }
        
        let url = URL(fileURLWithPath: pathString!)
        
        do{
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            let functions = try decoder.decode([Function].self, from: data)
            
            for f in functions{
                f.id = UUID()
                for e in f.expressions{
                    e.id = UUID()
                }
            }
            
            return functions
            
        }
        catch{
            print(error)
        }
        
        return [Function]()
    }
}
    
