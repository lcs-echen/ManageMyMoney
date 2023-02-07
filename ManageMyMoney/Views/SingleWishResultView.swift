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
        VStack (alignment: .leading){
                Text(priorResult.name)
                   .font(Font.system(size: 25))
                   .fontWeight(.semibold)
                   .padding(.leading, 30)
            HStack(alignment: .center) {
                Text("$" + priorResult.cost)
                    .font(Font.system(size: 36))
                    .fontWeight(.bold)
                Spacer()
                Text("x" + priorResult.amount)
                    .font(.title3)
                    .frame(width: 35, height: 35)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 4.5))
            }
            .padding(.horizontal, 30)
        }
        
    }
    
}

struct SingleWishResultView_Previews: PreviewProvider {
    static var previews: some View {
        SingleWishResultView(priorResult: wish1)
    }
}
