//
//  TrendingCreatorsView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 15/05/21.
//

import SwiftUI

struct TrendingCreatorsView: View {
    
    let users: [User] = [
        .init(username: "Amy Adams", profileImage: "amy"),
        .init(username: "Billy Childs", profileImage: "billy"),
        .init(username: "Samy", profileImage: "sam")
    ]
    
    var body: some View {
        HStack{
            Text("Trending Creators")
                .font(.system(size: 14,weight: .semibold))
            Spacer()
            Text("See all")
                .font(.system(size: 14,weight: .semibold))
        }.padding(.horizontal)
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 12){
                ForEach(users, id: \.self) { user in
                    
                    NavigationLink(
                        destination: ProfileDetailView(id: users.firstIndex(of: user) ?? 0),
                        label: {
                            DiscoverProfileView(user: user)
                        })
                }
            }.padding(.horizontal).padding(.vertical, 8)
            
        }
    }
}


struct TrendingCreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingCreatorsView()
    }
}
