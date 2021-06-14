//
//  ContentView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 04/05/21.
//

import SwiftUI
import Kingfisher

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct DiscoverView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor : UIColor.white
        ]
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()
                
                Color.defaultBackground.offset(y: 400)
                
                ScrollView {
                    
                    HStack() {
                        Image(systemName: "magnifyingglass")
                        Text("Where do you want to go?")
                        Spacer()
                    }.font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(white: 1, opacity: 0.3))
                    .cornerRadius(12)
                    .padding()
                    
                    
                    
                  DiscoveryCategoryView()
                    VStack {
                        PopularDestinationsView()
                        PopularRestaurantsView()
                        TrendingCreatorsView()
                    }
//                    .background(Color(white: 0.95, opacity: 1))
                    
                    .background(Color.defaultBackground)
                    .cornerRadius(16)
                    .padding(.top, 32)
                  
                }
            }
            
            .navigationTitle("Discovery")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            
        
    }
} 


