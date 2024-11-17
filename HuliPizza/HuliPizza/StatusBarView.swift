//
//  StatusBarView.swift
//  HuliPizza
//
//  Created by LinkedIn User on 11/16/22.
//

import SwiftUI

struct StatusBarView: View {
    @Binding var showOrders:Bool
    @Binding var presentGrid:Bool
    @EnvironmentObject var orders:OrderModel
    var body: some View {
        HStack {
            Text("\(orders.orderItems.count) orders")
            Spacer()
            Button{
                showOrders.toggle()
            } label:{
                Image(systemName: showOrders ? "cart" : "menucard")
                    
            }
            if !showOrders {
                Button{
                    presentGrid.toggle()
                } label:{
                    Image(systemName: presentGrid ? "square.grid.3x2" : "list.bullet")
                        
                }
            .padding(.leading,10)
            }
            Spacer()
            Label{
                Text(orders.orderTotal,format: .currency(code: "USD"))
            }icon:{
                Image(systemName: orders.orderItems.isEmpty ? "cart" : "cart.circle.fill")
                
            }
        
        }
        .foregroundStyle(.white)
        .font(.title2)
    }
}

struct StatusBarView_Previews: PreviewProvider {
    static var previews: some View {
        StatusBarView(showOrders: .constant(false), presentGrid: .constant(false)).environmentObject(OrderModel())
            .background(.black)
    }
}
