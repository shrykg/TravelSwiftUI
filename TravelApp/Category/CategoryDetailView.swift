//
//  CategoryDetailView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 07/06/21.
//

import SwiftUI
import Kingfisher

struct CategoryDetailView: View {
    
    private let name: String
    @ObservedObject private var vm: CategoryDetailViewModel
    
    init(name: String) {
        self.name = name
        self.vm = CategoryDetailViewModel(name: name)
    }
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                VStack {
                    ActivityIndicatorView()
                    Text("Loading..")
                        .foregroundColor(.white)
                }.padding()
                .background(Color.black)
                .cornerRadius(8)
                
            } else {
                ZStack {
                    if !vm.errorMessage.isEmpty {
                        VStack {
                            Image(systemName: "xmark.octagon.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 64))
                            Text(vm.errorMessage)
                        }
                    }
                    ScrollView{
                        ForEach(vm.places, id: \.self) { place in
                            VStack(alignment: .leading, spacing: 4) {
                                KFImage(URL(string: place.thumbnail))
                                    .resizable()
                                    .scaledToFill()
                                    
                                Text(place.name)
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding()
                            }
                            .background(Color.defaultBackground)
                                .cornerRadius(5)
                                .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2)
                            .padding()
                            
                        }
                    }

                }
            }
        }
        .navigationBarTitle(name, displayMode: .inline)
    }
    
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(name: "Food")
    }
}

class CategoryDetailViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    
    init(name: String) {
        
        let urlString = "http://travel.letsbuildthatapp.com/travel_discovery/category?name=\(name.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Bad status: \(statusCode)"
                    return
                }
                
                guard let data = data else {
                    self.isLoading = false
                    return
                }
                
                do {
                    self.places = try JSONDecoder().decode([Place].self, from: data)
                }
                catch {
                    print("failed to decode JSON: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
        }.resume()
    }
    
}
