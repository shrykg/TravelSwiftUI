//
//  DestinationHeaderContainer.swift
//  TravelApp
//
//  Created by Shreyak Godala on 09/06/21.
//

import SwiftUI
import Kingfisher

struct DestinationHeaderContainer: UIViewControllerRepresentable {
    
    let imageURLs: [String]
    var isFullScreen: Bool
    var selectedIndex: Int
    
    func makeUIViewController(context: Context) -> UIViewController {
        let pvc = CustomPageViewController(imageUrls: imageURLs, isFullScreen: isFullScreen, selectedIndex: selectedIndex)
        return pvc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
    
}

class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var selectedIndex = 0
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        allViewcontrollers.count
        
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        self.selectedIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = allViewcontrollers.firstIndex(of: viewController) else {return nil}
        if index == 0 {return nil}
        return allViewcontrollers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = allViewcontrollers.firstIndex(of: viewController) else {return nil}
        if index == allViewcontrollers.count - 1 {return nil}
        return allViewcontrollers[index + 1]
        
    }
    
    
//    let firstVC = UIHostingController(rootView: Text("First View Controller"))
//    let secondVC = UIHostingController(rootView: Text("Second View Controller"))
//    let thirdVC = UIHostingController(rootView: Text("Third View Controller"))
    
    lazy var allViewcontrollers: [UIViewController] = []
    
//    let imageURLs = [
//        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/7156c3c6-945e-4284-a796-915afdc158b5",
//              "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/b1642068-5624-41cf-83f1-3f6dff8c1702",
//              "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/6982cc9d-3104-4a54-98d7-45ee5d117531",
//              "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/2240d474-2237-4cd3-9919-562cd1bb439e"
//    ]
    
    
    init(imageUrls: [String], isFullScreen: Bool, selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        UIPageControl.appearance().pageIndicatorTintColor = .systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        allViewcontrollers = imageUrls.map({ string in
            let hostingVC = UIHostingController(rootView:
                                                    ZStack {
                                                        Color.black
                                                        KFImage(URL(string: string))
                                                                    .resizable()
                                                                                            .aspectRatio(contentMode: isFullScreen ? .fit : .fill)
                                                    }
                                                    
                )
            hostingVC.view.clipsToBounds = true
            return hostingVC
        })
        
        if selectedIndex < allViewcontrollers.count {
            setViewControllers([allViewcontrollers[selectedIndex]], direction: .forward, animated: true, completion: nil)
        }
        
        
//        if let firstVC = allViewcontrollers.first {
//            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
//        }
        
        self.dataSource = self
        self.delegate = self
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}


struct DestinationHeaderContainer_Previews: PreviewProvider {
    static var previews: some View {
        DestinationHeaderContainer(imageURLs: [], isFullScreen: false, selectedIndex: 0)
    }
}
