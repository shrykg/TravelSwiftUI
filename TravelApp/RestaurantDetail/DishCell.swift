//
//  DishCell.swift
//  TravelApp
//
//  Created by Shreyak Godala on 20/05/21.
//

import SwiftUI
import Kingfisher

struct DishCell: View {
    
    var dish: Dish
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            KFImage(URL(string: dish.photo))
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 100)
                .clipped()
                .cornerRadius(6)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
            
            Text(dish.name)
                .font(.system(size: 14, weight: .regular))
            Text("\(dish.numPhotos) photos")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray)
            
        }
    }
}

//struct DishCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DishCell(dish: Dish())
//    }
//}
