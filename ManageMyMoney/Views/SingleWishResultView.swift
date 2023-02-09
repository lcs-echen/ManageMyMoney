//
//  SingleWishResultView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-07.
//

import SwiftUI

struct SingleWishResultView: View {
    let priorResult: Wishes
    
    var body: some View {
        VStack (alignment: .leading, spacing: 9.0){
            Text(priorResult.name)
                .font(Font.system(size: 25))
                .fontWeight(.semibold)
            HStack(alignment: .center) {
                Text("x" + priorResult.amount)
                    .font(.subheadline)
                    .frame(width: 30, height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 3))
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                Spacer()
                Text("$")
                    .foregroundColor(Color("Orange"))
                    .font(Font.system(size: 20))
                + Text(priorResult.totalCost)
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
        SingleWishResultView(priorResult: wish1)
    }
}
