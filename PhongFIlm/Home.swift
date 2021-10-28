//
//  Home.swift
//  PhongFIlm
//
//  Created by PHONG on 15/10/2021.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        
        VStack(spacing: 15){
            HeaderView()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                ImageSlideShow()
                
                ADSView()
                    
                FilmCollectionVerticalView()
                
                FilmCollectionHorizontalView()
                
                FilmCollectionHorizontalView()
                
                ADSView()
            
            }).frame(maxWidth: getRect().width)

        }
        .frame(maxWidth: getRect().width, maxHeight: .infinity, alignment: .top)
        .background(
            Image("bgImg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: getRect().width, maxHeight: .infinity)
                .ignoresSafeArea()
        )
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


