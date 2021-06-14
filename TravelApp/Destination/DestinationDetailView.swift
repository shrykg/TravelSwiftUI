//
//  DestinationDetailView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 07/06/21.
//

import SwiftUI
import MapKit

class DestinationDetailViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var destinationDetail: DestinationDetail?
    
    init(name: String) {
        
        guard let url = URL(string: "http://travel.letsbuildthatapp.com/travel_discovery/destination?name=\(name.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {return}
                do {
                    self.destinationDetail = try JSONDecoder().decode(DestinationDetail.self, from: data)
                    self.isLoading = false
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }
        }.resume()
        
        
    }
    
}

struct DestinationDetailView: View {
    
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions = false
    
    @ObservedObject var vm: DestinationDetailViewModel
    
    let destination: Destination
    
    var attractions: [Attraction] = [
        .init(name: "Eiffel Tower", imageName: "eiffel_tower", latitude: 48.858605, longitude: 2.2946),
        .init(name: "Champs-Elysees",imageName: "japan", latitude: 48.866867, longitude: 2.311780),
        .init(name: "Louvre Museum",imageName: "new_york", latitude: 48.860288, longitude: 2.337789)
    ]
    
    init(destination: Destination) {
        self.destination = destination
        self.region = MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.vm = DestinationDetailViewModel(name: destination.name)
    }
    
    var body: some View {
        
        if vm.isLoading {
            VStack {
                ActivityIndicatorView()
                Text("Loading..")
                    .foregroundColor(.white)
            }.padding()
            .background(Color.black)
            .cornerRadius(8)
        } else {
        
        ScrollView {
            
            
            
            if let photos = vm.destinationDetail?.photos {
                DestinationHeaderContainer(imageURLs: photos, isFullScreen: false, selectedIndex: 0)
                    .frame(height: 250)
            }

            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.system(size: 18, weight: .semibold))
                Text(destination.countryName)
                    .font(.system(size: 16, weight: .regular))

                HStack {
                    ForEach(0...4, id: \.self) { num in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }.padding(.top, 2)

                Text(vm.destinationDetail?.description ?? "")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 2)

                HStack {
                    Spacer()
                }
            }.padding(.horizontal)

            HStack {
                Text("Location")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()

                Button(action: {isShowingAttractions.toggle()}, label: {
                    Text("\(isShowingAttractions ? "Hide" : "Show") Attractions")
                        .font(.system(size: 12, weight: .semibold))
                })

                Toggle(isOn: $isShowingAttractions, label: {
                }).labelsHidden()
            }.padding(.horizontal)


            Map(coordinateRegion: $region, annotationItems: isShowingAttractions ? attractions : []) { attraction in

                MapAnnotation(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude)) {
                    CustomAnnotation(attraction: attraction)
                }
            }.frame(height: 300)
            
            
        }.navigationBarTitle(destination.name, displayMode: .inline)
    }
    }
    
}

struct CustomAnnotation: View {
    
    let attraction: Attraction
    
    var body: some View {
        VStack {
            Image(attraction.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 60)
                .cornerRadius(4)
                
            Text(attraction.name)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .cornerRadius(3)
                .overlay(RoundedRectangle(cornerRadius: 3)
                            .stroke(Color(.gray))
                )
            
        }
    }
}

struct Attraction: Identifiable {
    var id = UUID().uuidString
    var name, imageName: String
    var latitude, longitude: Double
}

struct DestinationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DestinationDetailView(destination: Destination(name: "Paris", countryName: "France", image: "eiffel_tower",latitude: 48.8566, longitude: 2.3522))
        }
        
    }
}
