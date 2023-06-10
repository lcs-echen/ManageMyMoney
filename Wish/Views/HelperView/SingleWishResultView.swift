//
//  SingleWishResultView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-07.
//
import Blackbird
import SwiftUI

struct SingleWishResultView: View {
    
    var amount = 1
    var name = ""
    var rating = 3
    var totalCost = 0.00
    var type = ""
    

    
    var body: some View {
        VStack (alignment: .leading, spacing: 9.0){
            Text(name)
                .font(Font.system(size: 25))
                .fontWeight(.semibold)
            HStack(alignment: .center) {
                Group {
                    Text("x")
                    + Text("\(amount)")
                }
                    .font(.subheadline)
                    .frame(width: 30, height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 3))
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                
                Text("\(rating)/4❤️")
                
                Spacer()

                    Text("$ \(totalCost.formatted(.number.precision(.fractionLength(2))))")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                        .font(Font.system(size: 32))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Orange"))
                        


            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        
    }
    
}


struct SingleWishResultView_Previews: PreviewProvider {
    static var previews: some View {
        SingleWishResultView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
