//
//  DiscoverProfileView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 14/06/21.
//

import SwiftUI

struct DiscoverProfileView: View {
    
    let user: User
    
    var body: some View {
        VStack {
            Image(user.profileImage)
                .resizable()
                .scaledToFill()
                .cornerRadius(20)
                .frame(width: 40, height: 40)
                .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                
                
            Text(user.username)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color(.label))
                .multilineTextAlignment(.center)
                
        }
            .frame(width: 60)

    }
}


struct DiscoverProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverProfileView(user: User(username: "Shawn", profileImage: "amy"))
    }
}
