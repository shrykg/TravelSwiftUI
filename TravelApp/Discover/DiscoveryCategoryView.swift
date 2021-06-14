//
//  DiscoveryCategoryView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 15/05/21.
//

import SwiftUI

struct DiscoveryCategoryView: View {
    
    var categories = [
        Category(name: "Art", imageName: "paintpalette.fill"),
        Category(name: "Sports", imageName: "sportscourt.fill"),
        Category(name: "Live Events", imageName: "music.mic"),
        Category(name: "Food", imageName: "tray.fill"),
        Category(name: "History", imageName: "books.vertical.fill")
    ]
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(alignment: .top, spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    
                    NavigationLink(
                        destination: NavigationLazyView(CategoryDetailView(name: category.name)),
                        label: {
                            VStack(alignment: .center, spacing:8){
                                Image(systemName: category.imageName)
                                    .font(.system(size: 18))
                                    .foregroundColor(.orange)
                                    .frame(width: 50, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(25)
                                Text(category.name).font(.system(size: 12,weight: .semibold)).multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }.frame(width: 68)
                        })
                    
                }
            }.padding(.horizontal)
        }
    }
}

struct DiscoveryCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryCategoryView()
    }
}
