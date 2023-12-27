//
//  Home.swift
//  ScrollParalex
//
//  Created by David on 12/27/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15){
                DummySection(title: "Social Media")
                
                DummySection(title: "Sales", isLong: true)
                
                ParallaxImageView(usesFullWidth: true) { size in
                    Image(.pic1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 300)
                
                DummySection(title: "Media", isLong: true)
                
                DummySection(title: "markeing", isLong: true)
                
                ParallaxImageView(maximumMov: 150, usesFullWidth: false) { size in
                    Image(.pic2)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 400)
                
                DummySection(title: "markeing", isLong: true)
            }
            .padding(15)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func DummySection(title:String, isLong: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text(title)
                .font(.title.bold())
                
            
            Text("Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with \(isLong ? "Finibus Bonorum et Malorum for use in" : "")")
                .multilineTextAlignment(.leading)
                .kerning(1.2)
        })
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
}

struct ParallaxImageView<Content: View>: View {
    var maximumMov: CGFloat = 100
    @ViewBuilder var content: (CGSize) -> Content
    var usesFullWidth: Bool = false
    var body: some View {
        GeometryReader{
            let size = $0.size
            let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
            let scrollViewHeight = $0.bounds(of: .scrollView)?.size.height ?? 0
            let maximumMovement = min(maximumMov, (size.height * 0.35))
            let streteched: CGSize = .init(width: size.width, height: size.height + maximumMovement)
            
            let progress = minY / scrollViewHeight
            let cappedProgress = max(min(progress, 1.0), -1.0)
            let movementOffset = cappedProgress * -maximumMovement
            
            content(size)
                .offset(y: movementOffset)
                .frame(width: streteched.width, height: streteched.height)
                .frame(width: size.width, height: size.height)
             
                .clipped()
        }
        .containerRelativeFrame(usesFullWidth ? [.horizontal] : [] )
    }
}

#Preview {
    ContentView()
}
