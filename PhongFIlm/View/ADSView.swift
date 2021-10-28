//
//  ADSView.swift
//  PhongFIlm
//
//  Created by PHONG on 19/10/2021.
//

import SwiftUI

struct ADSView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray)
                .padding(.horizontal)
            
            Text("ADS")
        }
        .padding(.top, 10)
        .frame(width: getRect().width, height: isSmallScreen ? 80 : 100)
        
    }
}

struct ADSView_Previews: PreviewProvider {
    static var previews: some View {
        ADSView()
    }
}
