//
//  ContentView.swift
//  CostraCoffee
//
//  Created by Nafiz on 1/24/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject private var model: CoffeeModel = CoffeeModel()

    var body: some View {
        VStack {
            Spacer()
            Image("costra_logo")
                .resizable()
                .frame(width:280, height: 106)
            List (self.model.list, id: \.id) { item in
                HStack {
                    Image("coffee")
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                    VStack (alignment: .leading){
                        Text(item.name)
                        Text("\(item.price, specifier: "$%.2f")")
                    }
                }
                .frame(height: 80)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 8)
                        .background(Color.clear)
                        .foregroundColor(Color("list_item_bg"))
                        .padding(
                            EdgeInsets(
                                top: 5,
                                leading: 5,
                                bottom: 5,
                                trailing: 5
                            )
                        )
                )
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .background(Color("body"))
            .onAppear(perform: {
                model.fetchCoffee()
            })
        }
        .background(Color("body"))
    }

}
