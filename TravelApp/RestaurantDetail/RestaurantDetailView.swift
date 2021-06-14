//
//  RestaurantDetailView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 18/05/21.
//

import SwiftUI
import Kingfisher

struct RestaurantDetail: Decodable {
    var id: Int
    var name, city, country, category, description: String
    var photos: [String]
    var thumbnail: String
    var popularDishes: [Dish]
    var reviews: [Review]
}

struct Dish: Decodable, Hashable {
    var name, price, photo: String
    var numPhotos: Int
}

struct Review: Decodable, Hashable {
    var user: User
    var rating: Int
    var text: String
}

class RestaurantDetailViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var restaurantDetail: RestaurantDetail?
    
    init(id: Int) {
        guard let urlString = URL(string: "http://travel.letsbuildthatapp.com/travel_discovery/restaurant?id=\(id)") else {
            return
        }
        URLSession.shared.dataTask(with: urlString) { data, resp, err in
            
            DispatchQueue.main.async {
                if let err = err {
                    print("error loading : \(err.localizedDescription)")
                    return
                }
                guard let data = data else {return}
                do {
                    self.restaurantDetail = try JSONDecoder().decode(RestaurantDetail.self, from: data)
                } catch let error{
                    print("error decoding JSON: \(error)")
                    return
                }
            }
            
        }.resume()
    }
    
}


struct RestaurantDetailView: View {
    
    @ObservedObject var vm: RestaurantDetailViewModel
    
    init(id: Int) {
        self.vm = RestaurantDetailViewModel(id: id)
    }
    
    var body: some View {
        
        ScrollView {
            RestaurantDetailHeader(vm: vm)
            
            RestaurantDetailDescription(vm: vm)
            
            HStack {
                Text("Popular Dishes")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }.padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(vm.restaurantDetail?.popularDishes ?? [], id: \.self) { dish in
                        DishCell(dish: dish)
                    }
                }.padding(.horizontal)
            }
            
            HStack {
                Text("Customer Reviews")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }.padding()
            
            CustomerReviewView(vm: self.vm)
            
            
            
        }.navigationBarTitle(vm.restaurantDetail?.name ?? "", displayMode: .inline)
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RestaurantDetailView(id: 0)
                .navigationBarTitle("Restaurant", displayMode: .inline)
        }
    }
}


struct CustomerReviewView: View {
    
    @ObservedObject var vm: RestaurantDetailViewModel
    
    var body: some View {
        
        VStack(spacing: 32) {
            ForEach(vm.restaurantDetail?.reviews ?? [], id: \.self) { review in
                CustomerReviewCell(review: review)
            }
        }
        
    }
}

struct CustomerReviewCell: View {
    
    var review: Review
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                KFImage(URL(string: review.user.profileImage))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .cornerRadius(20)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(review.user.username)
                        .font(.system(size: 16, weight: .semibold))
                    HStack {
                        ForEach(1...5, id: \.self) { num in
                            Image(systemName: "star.fill")
                                .foregroundColor(num > review.rating ? .gray : .orange)
                                .font(.caption2)
                        }
                        
                    }
                    
                }
                
                Spacer()
                
                Text("Dec 2020")
                    .font(.system(size: 16, weight: .regular))
                
            }
            
            HStack {
                Text(review.text)
                Spacer()
            }
            
            
            
        }.padding(.horizontal)
    }
}
