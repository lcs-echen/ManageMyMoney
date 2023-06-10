//
//  AddTypeView.swift
//  Wish
//
//  Created by Evelyn Chen on 2023-06-06.
//

import SwiftUI
import Blackbird

struct AddTypeView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    @State var type: String = ""
    var body: some View {
        NavigationView{

            HStack(alignment: .top)  {
                Text("Type: ")
                    .font(.title3)
                TextField("Please enter the type you want to add", text: $type)
                    .padding(.bottom, 10)
            }
            .padding(.horizontal)
            .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button(action: {
                                    addWish()
                                }, label: {
                                    Text("Add")
                                })
                                .disabled(type == "")
                            }
                        }

        }
        .accentColor(Color("Orange"))
       
    }
    
    func addWish() {
        Task {
            try await db!.transaction { core in
                try core.query("""
                            INSERT INTO WishType (
                            type
                            )
                            VALUES (
                                (?)
                            )
                            """,
                            type)
            }
            // Reset input fields after writing to database
            type = ""
        }
    }
}

struct AddTypeView_Previews: PreviewProvider {
    static var previews: some View {
        AddTypeView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
