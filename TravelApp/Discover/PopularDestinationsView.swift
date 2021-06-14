//
//  PopularDestinationsView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 15/05/21.
//

import SwiftUI



struct PopularDestinationsView: View {

    
    
    let destinations: [Destination] = [
        .init(name: "Paris", countryName: "France", image: "eiffel_tower", latitude: 48.856, longitude: 2.3522),
        .init(name: "Tokyo", countryName: "Japan", image: "japan", latitude: 35.6762, longitude: 139.6503),
        .init(name: "New York", countryName: "US", image: "new_york", latitude: 40.7128, longitude: 74.0060)
    ]

    

    var body: some View {
        HStack{
            Text("Popular Destinations")
                .font(.system(size: 14,weight: .semibold))
            Spacer()
            Text("See all")
                .font(.system(size: 14,weight: .semibold))
        }.padding(.horizontal).padding(.top)
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing: 12){
                ForEach(destinations, id: \.self) { destination in
                    
                 NavigationLink(
                    destination: NavigationLazyView(DestinationDetailView(destination: destination))
                        ,
                    label: {
                        DestinationsTile(destination: destination)
                    })
                    
                }
            }.padding(.horizontal).padding(.bottom)
        }
    }

}

struct DestinationsTile: View {
    
    let destination: Destination
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            Image(destination.image)
                .resizable()
                .scaledToFill()
                .frame(width: 125, height: 125)
                .clipped()
                .cornerRadius(6)
                .padding(.horizontal, 6)
                .padding(.vertical, 6)

            Text(destination.name)
                .font(.system(size: 14,weight: .semibold))
                .padding(.horizontal)
                .foregroundColor(Color(.label))

            Text(destination.countryName)
                .font(.system(size: 14,weight: .semibold))
                .foregroundColor(Color(.gray))
                .padding(.horizontal)
                .padding(.bottom, 8)
        }

        .background(Color.tileBackground)
            .cornerRadius(5)
        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
        

    }
    
}


struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularDestinationsView()
        DiscoverView()
    }
}
