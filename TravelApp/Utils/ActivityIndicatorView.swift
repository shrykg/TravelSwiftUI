//
//  ActivityIndicatorView.swift
//  TravelApp
//
//  Created by Shreyak Godala on 07/06/21.
//

import SwiftUI

extension Color {
    static var defaultBackground = Color("defaultBackground")
    static var tileBackground = Color("tileBackground")
}

struct ActivityIndicatorView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.startAnimating()
        aiv.color = .white
        return aiv
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
    typealias UIViewType = UIActivityIndicatorView
    
    
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
