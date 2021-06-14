//
//  RestaurantPhotosView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 10/06/21.
//

import SwiftUI
import Kingfisher

struct RestaurantPhotosView: View {
    
    var imageURLs: [String]
    
    var dummyimageURLs = [
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/92bb86e7-5417-4450-9870-cae93cfd33c4",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/4116ad7a-78fe-41b5-97e2-82b0748885d9",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/def50b63-fc4e-4ca0-9d14-69f2ee3b661a",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/9777b95e-fdae-4664-9ca5-394761e3312d",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/3b57304a-723c-48b2-8ad8-82c204297c5d",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/abc458e6-1d7f-4e6b-8e90-a7e35b0d45aa",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/0398dcab-7836-47e4-92ff-d41a262465eb"
    ]
    
    @State var mode = "list"
    @State var shouldShowModal = false
    @State var selectedIndex = 0
    
    init(imageUrls: [String]) {
        UISegmentedControl.appearance().backgroundColor = .black
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        self.imageURLs = imageUrls
        
    }
    
    var body: some View {
        
        
            
            GeometryReader(content: { geometry in
                ScrollView{
                    
                    Picker("Title", selection: $mode) {
                        Text("Grid").tag("grid")
                        Text("List").tag("list")
                    }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Spacer().fullScreenCover(isPresented: $shouldShowModal, content: {
                        ZStack(alignment: .topLeading) {
                            Color.black.ignoresSafeArea()
                            DestinationHeaderContainer(imageURLs: imageURLs, isFullScreen: true, selectedIndex: selectedIndex)
                            Button(action: {
                                shouldShowModal.toggle()
                            }, label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 32, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding()
                            })
                        }
                    }).opacity(shouldShowModal ? 1 : 0) // reload view
                    
                    
                    if mode == "grid" {
                        LazyVGrid(columns: [
                            GridItem(.adaptive(minimum: geometry.size.width - 4 / 3, maximum: 500), spacing: 2),
                            GridItem(.adaptive(minimum: geometry.size.width - 4 / 3, maximum: 500), spacing: 2),
                            GridItem(.adaptive(minimum: geometry.size.width - 4 / 3, maximum: 500), spacing: 2)
                        ], spacing: 1, content: {
                            
                            ForEach(imageURLs, id: \.self) { url in
                                
                                Button(action: {
                                    self.selectedIndex = imageURLs.firstIndex(of: url) ?? 0
                                    shouldShowModal.toggle()
                                }, label: {
                                    KFImage(URL(string: url))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                                        .clipped()
                                })
                            }
                        })

                    } else {
                        ForEach(imageURLs, id: \.self) { url in
                            
                            VStack(alignment: .leading, spacing: 8){
                                KFImage(URL(string: url))
                                    .resizable()
                                    .scaledToFill()
                                
                                HStack {
                                    Image(systemName: "heart")
                                    Image(systemName: "bubble.right")
                                    Image(systemName: "paperplane")
                                    Spacer()
                                    Image(systemName: "bookmark")
                                }.padding(.horizontal, 8)
                                .font(.system(size: 22))
                                
                                Text("Description of your post and make sure it goes a couple of lines to check properly the multiline property wrapped in scrollview.\n\nGreat job guys.")
                                    .padding(.horizontal, 8)
                                    .font(.system(size: 14))
                                
                                Text("Posted on 23/06/2021")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                                    .padding(.horizontal, 8)
                                
                            }.padding(.bottom)
                            
                        }
                    }
                    
                    
                }.navigationBarTitle("All Photos", displayMode: .inline)
            })

        
        
    }
}

struct RestaurantPhotosView_Previews: PreviewProvider {
    
    static var dummyimageURLs = [
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/92bb86e7-5417-4450-9870-cae93cfd33c4",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/4116ad7a-78fe-41b5-97e2-82b0748885d9",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/def50b63-fc4e-4ca0-9d14-69f2ee3b661a",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/9777b95e-fdae-4664-9ca5-394761e3312d",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/3b57304a-723c-48b2-8ad8-82c204297c5d",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/abc458e6-1d7f-4e6b-8e90-a7e35b0d45aa",
              "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/0398dcab-7836-47e4-92ff-d41a262465eb"
    ]
    
    static var previews: some View {
        RestaurantPhotosView(imageUrls: dummyimageURLs)
    }
}
