//
//  FormulaView.swift
//  Conversions
//
//  Created by Matt Dahl on 1/9/22.
//

import SwiftUI

struct FormulaView: View {
    
    @EnvironmentObject var model: FunctionModel
    @State var wheelOptions: [String] = [String]()
    
    @State var categoryFunctions = [Function]()
    
    let category: String
    @State var currentFunction: Int
    @State var currentExpression: Int
    
    @State var selectedWheelIndex: Int
    
    @State var selectedBox: Int = 0
    
    @State var solutionLabel: String = ""
    @State var inputLabels: [String] = [String]()
    
    @State var keyboardOpen: Bool = false
    
    
    
    var body: some View {
        VStack {
            ScrollView{
                VStack(alignment: .leading){
                    if(categoryFunctions.count > currentFunction){
                        ForEach(0..<categoryFunctions[currentFunction].expressions[currentExpression].inputs.count, id: \.self){i in
                            Text("Input \(model.intToString(i+1))")
                                .font(.subheadline)
                                .padding(.bottom, -5)
                            HStack(alignment: .center, spacing: 15){
                                if(i == 0 && categoryFunctions[currentFunction].expressions.count > 1){
                                    Button(action: {
                                        selectedBox = i+1
                                    }) {
                                        InputCardView(alpha: 0.12, height: 41, selected: selectedBox == i+1, label: categoryFunctions[currentFunction].expressions[currentExpression].inputs[i], showArrow: true)
                                            .foregroundColor(.black)
                                    }
                                } else{
                                    InputCardView(alpha: 0.12, height: 41, selected: selectedBox == i+1, label: categoryFunctions[currentFunction].expressions[currentExpression].inputs[i], showArrow: false)
                                        .foregroundColor(.black)
                                }
                                
                                InputTextView(amount: String(model.inputs[i] ?? -1.0), id: i)
                                    .onTapGesture(perform: {
                                        keyboardOpen = true
                                    })
                            }
                            .padding(.bottom, 30)
                        }
                    }
                    
                    
                    
                    
                    Text("Solution")
                        .font(.headline)
                        .padding(.bottom, -5)
                    HStack(alignment: .center, spacing: 15){
                        Button(action: {
                            selectedBox = 0
                        }) {
                            InputCardView(alpha: 0.42, height: 47, selected: selectedBox == 0, label: solutionLabel, showArrow: true)
                                .foregroundColor(.black)
                        }
                        
                        SolutionCardView(category: category, alpha: 0.42, height: 47, text: model.solveFunction(functionIndex: currentFunction, expressionIndex: currentExpression, availableFuncs: categoryFunctions))
                    }
                    .padding(.bottom, 30)

                    
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 15)
            }
            
            if(!keyboardOpen){
                VStack(alignment: .leading){
                    //MARK: Wheel
                    Picker("wheel", selection: $selectedWheelIndex, content: {
                        ForEach(0..<wheelOptions.count, id: \.self){ i in
                            Text(wheelOptions[i]).tag(i)
                        }
                    })
                        .pickerStyle(.wheel)
                        .padding(.horizontal, 20)
                }
                .background(Color(.sRGB, red: 0.7, green: 0.7, blue: 0.7, opacity: 0.3))
            }
        }
        .navigationTitle(category.first!.uppercased() + category.dropFirst())
        .navigationBarItems(trailing:
                        Button(action: {
                            alertView()
                            //SAVE FUNCTION TO model favorite

                        }) {
                            Image(systemName: "plus.circle")
                        }
                    )
        .onAppear(){
            categoryFunctions = model.getFunctionsForCategory(category: category)
            wheelOptions = model.getSolutionsFromFunctions(arr: categoryFunctions)
            solutionLabel = categoryFunctions[currentFunction].solution
            
            if(category != model.lastCategory){
                model.resetInputs()
            }
            
            model.lastCategory = category
            
        }
        .onChange(of: selectedBox, perform: {newBox in
            if(newBox == 0){
                wheelOptions = model.getSolutionsFromFunctions(arr: categoryFunctions)
                selectedWheelIndex = currentFunction
            } else{
                //if user selects input box
                wheelOptions = model.getFirstInputsFromFunction(function: categoryFunctions[currentFunction])
                selectedWheelIndex = currentExpression
                
            }
            
            
        })
        .onChange(of: selectedWheelIndex, perform: {newSelection in
            if(selectedBox == 0){
                if(solutionLabel != categoryFunctions[newSelection].solution){
                    currentExpression = 0
                }
                solutionLabel = categoryFunctions[newSelection].solution
                currentFunction = newSelection
                
            } else{
                //inputLabels[selectedBox - 1] = wheelOptions[newSelection]
                currentExpression = newSelection
            }
        })
        .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                keyboardOpen = false
            
        }
        
    }
    
    func alertView(){
        let alert = UIAlertController(title: "Add Favorite", message: "What would you like the name for this favorite to be?", preferredStyle: .alert)
        
        alert.addTextField{ title in
            title.placeholder = "Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive){(_) in
            
        }
        let addAction = UIAlertAction(title: "Add", style: .default){ (_) in
            let addFavName = alert.textFields![0].text!
            
            let newFav = Favorite(id: UUID(), title: addFavName, inputs: categoryFunctions[currentFunction].expressions[currentExpression].inputs, inputValues: model.getValidInputs(), solution: solutionLabel, solutionValue: model.solveFunction(functionIndex: currentFunction, expressionIndex: currentExpression, availableFuncs: categoryFunctions), category: category, functionIndex: currentFunction, expressionIndex: currentExpression, wheelIndex: currentFunction)
                            
            model.addToFavorites(newFav: newFav)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion:{
        })
    }
}

struct InputCardView: View{
    
    var alpha: CGFloat
    var height: CGFloat
    var selected: Bool
    var label: String
    var showArrow: Bool
    
    var body: some View{
        ZStack{
            if(selected){
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(Color(.sRGB, red: 0.7, green: 0.7, blue: 0.7, opacity: alpha))
                    .frame(height: height, alignment: .center)
                    .overlay(
                            RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gray, lineWidth: 1)
                        )
            }
            else{
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(Color(.sRGB, red: 0.7, green: 0.7, blue: 0.7, opacity: alpha))
                    .frame(height: height, alignment: .center)
            }
            
            HStack{
                Text(label)
                Spacer()
                if(showArrow){
                    Image(systemName: "chevron.up.chevron.down")
                        .foregroundColor(Color(.sRGB, red: 0.38, green: 0.38, blue: 0.38, opacity: 1))
                }
            }
            .padding()
        }
    }
}


struct InputTextView: View{
    
    @EnvironmentObject var model: FunctionModel
    @State var amount: String
    var id: Int
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(Color(.sRGB, red: 0.7, green: 0.7, blue: 0.7, opacity: 0.12))
                .frame(height: 43, alignment: .center)
            TextField("",text: $amount)
                .keyboardType(.decimalPad)
                .frame(height: 43, alignment: .center)
                .padding(.horizontal)
        }
        .onChange(of: amount, perform: {amt in
            var toAdd = amt
            if(toAdd.count > 0){
                if(toAdd.first == "."){
                    toAdd = "0" + amt
                }
                model.addInput(toAdd: Double(toAdd)!, index: id)
            }
            else{
                model.addInput(toAdd: nil, index: id)
            }
        
        })
        .onAppear(perform: {
            if(amount == "-1.0"){
                amount = ""
            }
        })
    }
}


struct SolutionCardView: View{
    
    var category: String
    var alpha: CGFloat
    var height: CGFloat
    var text: String
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(Color(.sRGB, red: 0.7, green: 0.7, blue: 0.7, opacity: alpha))
                .frame(height: height, alignment: .center)
            
            
            HStack{
                if(category == "pricing"){
                    Text("$")
                }
                Spacer()
                Text(text)
            }
            .padding()
        }
    }
}




struct FormulaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            FormulaView(category: "pricing", currentFunction: 0, currentExpression: 0, selectedWheelIndex: 0)
                .environmentObject(FunctionModel())
        }
    }
}
