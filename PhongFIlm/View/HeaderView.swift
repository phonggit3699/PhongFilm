//
//  HeaderView.swift
//  PhongFIlm
//
//  Created by PHONG on 17/10/2021.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(spacing: 15){
            HStack(spacing: 3) {
                Image(systemName: "film")
                    .resizable()
                    .foregroundColor(.blue)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                
                Text("Phong Film")
                    .foregroundColor(.blue)
                    .font(.system(size: 30, weight: .heavy,design: .default))
            }
            
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "bell")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                
            })
            
            Button(action: {}, label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                
            })
            
        }
        .padding(.horizontal)

        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
