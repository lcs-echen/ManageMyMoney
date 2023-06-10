//
//  SingleTypeView.swift
//  Wish
//
//  Created by Evelyn Chen on 2023-06-07.
//

import SwiftUI

struct SingleTypeView: View {
    var typeName = "Car"
    var wishCount = 2
    var wishCostSum = "1800.0"
    var body: some View {
        VStack(alignment: .leading) {
            Text(typeName)
                .font(Font.system(size: 30))
                .fontWeight(.semibold)
        
            HStack {
                HStack{
                    Text("x \(wishCount)")
                        .font(.subheadline)
                        .frame(width: 30, height: 30)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 3))
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                }
            
                Group {
                    Text("$")
                        .foregroundColor(Color("Orange"))
                        .font(Font.system(size: 20))
                    + Text(wishCostSum)
                        .font(Font.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Orange"))
                }
                .padding(.leading, 8.0)
                
                
                Spacer()
            }
        }
    }
}

struct SingleTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SingleTypeView()
    }
}
