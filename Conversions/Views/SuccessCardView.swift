//
//  SuccessCardView.swift
//  Conversions
//
//  Created by Matt Dahl on 1/15/22.
//

import SwiftUI

struct SuccessCardView: View {
    
    var sysImage: String
    var text: String
    @State var opac = 1.0
    
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(.sRGB, red: 0.95, green: 0.95, blue: 0.95, opacity: 1))
                .frame(width: 150, height: 150, alignment: .center)
            
            
            HStack{
                VStack{
                    Image(systemName: sysImage)
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.green)
                        .padding(.top)
                    Text(text)
                        .padding()
                }
            }
            .padding()
        }
        .opacity(opac)
    }
    
    func updateOpac(op: Double){
        self.opac = op
    }
}

struct SuccessCardView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessCardView(sysImage: "checkmark", text: "Added")
    }
}
