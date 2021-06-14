//
//  PopularRestaurantsView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 15/05/21.
//

import SwiftUI

struct PopularRestaurantsView: View 
    {
        
        let restaurants: [Restaurant] = [
            .init(name: "Japan's Finest Tapas", image: "tapas"),
            .init(name: "Bar & Grill", image: "bar_grill")
        ]
        
        var body: some View {
            HStack{
                Text("Popular places to eat")
                    .font(.system(size: 14,weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 14,weight: .semibold))
            }.padding(.horizontal)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 12){
                    ForEach(restaurants, id: \.self) { restaurant in
                        
                        NavigationLink(
                            destination: RestaurantDetailView(id: restaurants.firstIndex(of: restaurant) ?? 0),
                            label: {
                                HStack {
                                    Image(restaurant.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 64, height: 64)
            //                            .clipped()
                                        .cornerRadius(4)
                                        .padding(.leading, 6)
                                        .padding(.vertical,6)
                                        
                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack {
                                            Text(restaurant.name)
                                            Spacer()
                                            Button(action: {}, label: {
                                                Image(systemName: "ellipsis")
                                                    .foregroundColor(.gray)
                                            })
                                        }
                                        
                                        HStack {
                                            Image(systemName: "star.fill")
                                            Text("4.7 • Sushi • $$")
                                        }
                                        Text("Tokyo, Japan")
                                    }.font(.system(size: 12,weight: .semibold))
                                    
                                    Spacer()
                                }

                            }).foregroundColor(Color(.label))
                        
//                        HStack {
//                            Image(restaurant.image)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 64, height: 64)
//    //                            .clipped()
//                                .cornerRadius(4)
//                                .padding(.leading, 6)
//                                .padding(.vertical,6)
//
//                            VStack(alignment: .leading, spacing: 6) {
//                                HStack {
//                                    Text(restaurant.name)
//                                    Spacer()
//                                    Button(action: {}, label: {
//                                        Image(systemName: "ellipsis")
//                                            .foregroundColor(.gray)
//                                    })
//                                }
//
//                                HStack {
//                                    Image(systemName: "star.fill")
//                                    Text("4.7 • Sushi • $$")
//                                }
//                                Text("Tokyo, Japan")
//                            }.font(.system(size: 12,weight: .semibold))
//
//                            Spacer()
//                        }
                        

                            .frame(width: 240)
                        .background(Color.tileBackground)
                            .cornerRadius(5)
                            .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                    }
                }.padding(.horizontal).padding(.bottom)
            }
        }
        
    }

struct PopularRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularRestaurantsView()
    }
}
