//
//  ProfileDetailView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 14/06/21.
//

import SwiftUI
import Kingfisher

struct UserDetail: Decodable {
    
    var username, firstName, lastName, profileImage: String
    var followers, following: Int
    var posts: [Userpost]
    
}

struct Userpost: Decodable, Hashable {
    var title, imageUrl, views: String
    var hashtags: [String]
}

class ProfileDetailViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var userDetail: UserDetail?
    
    init(id: Int) {
        
        guard let url = URL(string: "http://travel.letsbuildthatapp.com/travel_discovery/user?id=\(id)") else {return}
        
        URLSession.shared.dataTask(with: url) {  data, resp, err in
            guard let data = data else {
                return
            }
            
            do{
                self.userDetail = try JSONDecoder().decode(UserDetail.self, from: data)
                
            }catch {
                print("Error decoding JSON: \(error)")
               return
            }
            
        }.resume()
        
        
    }
    
}


struct ProfileDetailView: View {
    
//    let user: User
    
    @ObservedObject var vm: ProfileDetailViewModel
    
    init(id: Int) {
        
        self.vm = ProfileDetailViewModel(id: id)
    }
    
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 12) {
                KFImage(URL(string: vm.userDetail?.profileImage ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.top)
                
                Text("\(vm.userDetail?.firstName ?? "") \(vm.userDetail?.lastName ?? "")")
                    .font(.system(size: 14, weight: .semibold))
                
                HStack {
                    Text("\(vm.userDetail?.username ?? "") •")
                    Image(systemName: "hand.thumbsup.fill")
                    Text("2341")
                }.font(.system(size: 12, weight: .regular))
                
                Text("Youtuber, Vlogger, Travel Creator")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(.lightGray))
                
                HStack(spacing: 12) {
                    VStack {
                        Text("\(vm.userDetail?.followers ?? 0)")
                            .font(.system(size: 14, weight: .bold))
                        Text("Followers")
                            .font(.system(size: 12, weight: .regular))
                    }
                    Spacer()
                        .frame(width: 1, height: 20)
                        .background(Color(.lightGray))
                    
                    VStack {
                        Text("\(vm.userDetail?.following ?? 0)")
                            .font(.system(size: 14, weight: .bold))
                        Text("Following")
                            .font(.system(size: 12, weight: .regular))
                    }
                }
                
                HStack(spacing: 12) {
                    Button(action: {}, label: {
                        HStack {
                            Spacer()
                            Text("Follow")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                        }
                            
                        .padding(.vertical, 8)
                        .background(Color.orange)
                        .cornerRadius(24)
                        
                    })
                    
                    Button(action: {}, label: {
                        HStack {
                            Spacer()
                            Text("Following")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                            
                        .padding(.vertical, 8)
                        .background(Color(.lightGray))
                        .cornerRadius(24)
                        
                    })

                }
                
                ForEach(vm.userDetail?.posts ?? [], id: \.self) { post in
                    
                    VStack(alignment: .leading) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                        
                        HStack(alignment: .center) {
                            KFImage(URL(string: vm.userDetail?.profileImage ?? ""))
                                .resizable()
                                .scaledToFit()
                                .frame(height: 34)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text("\(post.title)")
                                    .font(.system(size: 12, weight: .semibold))
                                    .fixedSize(horizontal: false, vertical: true)
                                Text("\(post.views) views")
                                    .font(.system(size: 10, weight: .regular))
                                    .foregroundColor(Color(.gray))
                                
                            }
                        }.padding(.horizontal, 8)
                        
                        HStack(spacing: 8) {
                            ForEach(post.hashtags, id: \.self) { tag in
                                
                                Text("#\(tag)")
                                    .padding(.horizontal, 8)
                                    .background(Color(.blue).opacity(0.1))
                                    .cornerRadius(10)
                                
                            }
                        }.font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding(.horizontal,8)
                        .padding(.bottom)
                        
                    }
                    .background(Color.tileBackground)
                        .cornerRadius(24)
                        .shadow(radius: 4)
                        .padding(.bottom,8)
                        
                        
                        
                }
                
                
            }.padding(.horizontal)
            
            
            
        }.navigationBarTitle("\(vm.userDetail?.firstName ?? "") \(vm.userDetail?.lastName ?? "")", displayMode: .inline)
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(id: 0)
    }
}
