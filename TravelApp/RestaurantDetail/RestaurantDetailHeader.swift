//
//  RestaurantDetailHeader.swift
//  TravelApp
//
//  Created by Shreyak Godala on 20/05/21.
//

import SwiftUI
import Kingfisher

struct RestaurantDetailHeader: View {
    
    @ObservedObject var vm: RestaurantDetailViewModel
    
    var body: some View {
        ZStack {
            
            KFImage(URL(string: vm.restaurantDetail?.thumbnail ?? ""))
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .clipped()
            
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .bottom, endPoint: .center)
            
            
            VStack (alignment: .leading, spacing: 4){
                Spacer()
                
                HStack {
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(vm.restaurantDetail?.name ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .heavy))
                        
                        HStack {
                            ForEach(0...4, id: \.self) { num in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                                    .font(.caption)
                            }
                            
                        }

                        
                    }
                    
                    Spacer()
                    
                    
                    NavigationLink(
                        destination: RestaurantPhotosView(imageUrls: vm.restaurantDetail?.photos ?? []),
                        label: {
                            Text("See more photos")
                                .foregroundColor(.white)
                                .frame(width: 80)
                        })
                    
//                    Button(action: {
//
//                    }, label: {
//                        Text("See more photos")
//                            .foregroundColor(.white)
//                            .frame(width: 80)
//                    })

                }
                
//                VStack {
//                    Text(vm.restaurantDetail?.name ?? "")
//                        .foregroundColor(.white)
//                        .font(.system(size: 22, weight: .heavy))
//
//                    HStack {
//                        ForEach(0...4, id: \.self) { num in
//                            Image(systemName: "star.fill")
//                                .foregroundColor(.orange)
//                                .font(.caption)
//                        }
//
//                    }
//
//
//                }
                
                
                
//                HStack {
//                    ForEach(0...4, id: \.self) { num in
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.orange)
//                            .font(.caption)
//                    }
//
//                }
                
            }.padding(.horizontal, 12).padding(.bottom, 12)
        }
    }
}


struct RestaurantDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailHeader(vm: RestaurantDetailViewModel(id: 0))
    }
}
