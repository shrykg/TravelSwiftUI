//
//  RestaurantDetailDescription.swift
//  TravelApp
//
//  Created by Shreyak Godala on 20/05/21.
//

import SwiftUI

struct RestaurantDetailDescription: View {
    
    @ObservedObject var vm: RestaurantDetailViewModel
    
    var body: some View {
        VStack(alignment:.leading, spacing: 8) {
            
            HStack{
                Text("Location & Description")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }.padding(.horizontal).padding(.top, 12)
            
            Text("\(vm.restaurantDetail?.city ?? ""), \(vm.restaurantDetail?.country ?? "")")
                .padding(.horizontal)
                .font(.system(size: 14, weight: .regular))
            
            HStack{
                Image(systemName: "dollarsign.circle.fill")
                Image(systemName: "dollarsign.circle.fill")
                Image(systemName: "dollarsign.circle.fill")
            }.foregroundColor(.orange)
            .padding(.horizontal)
            
            Text(vm.restaurantDetail?.description ?? "")
                .padding(.horizontal)
            
        }
    }
}


//struct RestaurantDetailDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantDetailDescription()
//    }
//}
