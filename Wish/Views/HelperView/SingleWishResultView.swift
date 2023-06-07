//
//  SingleWishResultView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-07.
//
import Blackbird
import SwiftUI

struct SingleWishResultView: View {
    
    var amount = "1"
    var name = ""
    var rating = 3
    var totalCost = ""
    var type = ""
    
    var formattedAmount: String {
        return Double(amount)!.formatted(.number.precision(.fractionLength(0)))
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 9.0){
            Text(name)
                .font(Font.system(size: 25))
                .fontWeight(.semibold)
            HStack(alignment: .center) {
                Group {
                    Text("x")
                    + Text(formattedAmount)
                }
                    .font(.subheadline)
                    .frame(width: 30, height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 3))
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                
                Text("\(rating)/4❤️")
                
                Spacer()
                Text("$")
                    .foregroundColor(Color("Orange"))
                    .font(Font.system(size: 20))
                + Text(totalCost)
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
