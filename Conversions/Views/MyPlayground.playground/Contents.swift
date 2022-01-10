import Cocoa


func solveEquation(eq: String, inputs: [Double]) -> Double{
    
    var filledInEq = eq.replacingOccurrences(of: "A", with: String(inputs[0]))
    if(inputs.count > 1){
        filledInEq = filledInEq.replacingOccurrences(of: "B", with: String(inputs[1]))
    }
    if(inputs.count > 2){
        filledInEq = filledInEq.replacingOccurrences(of: "C", with: String(inputs[2]))
    }
    if(inputs.count > 3){
        filledInEq = filledInEq.replacingOccurrences(of: "D", with: String(inputs[3]))
    }
    
    
    let expression = NSExpression(format:filledInEq)
    print(expression)
    let value: Double = expression.expressionValue(with: nil, context: nil) as! Double
    print(value)
    return value
}


var equation = "A * (3.280839895 * 3.280839895) / 1000"
var inputs = [Double]()
inputs.append(1295)
inputs.append(5)

print(solveEquation(eq: equation, inputs: inputs))
