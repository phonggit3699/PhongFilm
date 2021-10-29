//
//  CustomSlider.swift
//  PhongFIlm
//
//  Created by PHONG on 24/10/2021.
//

import SwiftUI
import AVKit

struct CustomSlider: View {
    
    @Binding var value: CGFloat
    @Binding var avPlayer: AVPlayer?
    @Binding var isFullScreen: Bool
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Capsule()
                .fill(Color.gray)
                .frame(height: 4)
            
            Capsule()
                .fill(Color.blue)
                .frame(width: self.value > 0 ? self.value * getWidthSlider() : 0, height: 4)
            
            Circle()
                .fill(Color.blue)
                .frame(width: 14 ,height: 14)
                .offset(x: -7)
                .offset(x: self.value > 0 ? self.value * getWidthSlider() : 0)
                .gesture(DragGesture().onChanged({ value in
                   onDragChanged(value: value)
                }))
            
        }.frame(width: getWidthSlider())

    }
}

extension CustomSlider {
    func onDragChanged(value: DragGesture.Value){
        if value.location.x >= getWidthSlider() {
            self.value = 1.0
        }
        
        if value.location.x > 0 && value.location.x <= getWidthSlider(){
            let sec: Double = Double(Float(self.value) * Float((self.avPlayer?.currentItem?.duration.seconds)!))
            self.value = value.location.x / getWidthSlider()
            self.avPlayer?.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
        }
    }
    
    func getWidthSlider() -> CGFloat{
        if self.isFullScreen {
            return getRect().height - 150
        }else{
            return getRect().width - 150
        }
    }
}


