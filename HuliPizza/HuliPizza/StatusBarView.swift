//
//  StatusBarView.swift
//  HuliPizza
//
//  Created by Sravya Kaki on 11/15/24.
//

import SwiftUI

struct StatusBarView: View {
    @ObservedObject var orders:OrderModel
    @State private var showOrders:Bool = false
    @State private var selectedItem:MenuItem = noMenuItem
    var menu:[MenuItem]

    var body: some View {
        HStack {
            Text("\(orders.orderItems.count) orders")
            Spacer()
            Button{
                showOrders.toggle()
            } label:{
                Image(systemName: showOrders ? "cart" : "menucard")
                
            }
            Spacer()
            Label{
                Text(orders.orderTotal,format: .currency(code: "USD"))
            }icon:{
                Image(systemName: orders.orderItems.isEmpty ? "cart" : "cart.circle.fill")
                
            }
        }
        .padding()
        .foregroundStyle(.white)
        .font(.title2)
        if showOrders
        {
            OrderView(orders: orders)
                .cornerRadius(10)
        }
        else{
            MenuItemView(item:$selectedItem, orders: orders)
                .padding(5)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10))
            MenuView(menu:menu, selectedItem: $selectedItem)
            
        }
        
    }
    
}

#Preview {
    StatusBarView(orders: OrderModel(), menu:MenuModel().menu)
}
