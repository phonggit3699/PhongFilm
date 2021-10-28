//
//  Extenstion.swift
//  PhongFIlm
//
//  Created by PHONG on 17/10/2021.
//
import SwiftUI

extension View {
    
    public var isSmallScreen: Bool {
        return getRect().width <= 375.0
    }
    
    public var textColor: Color{ return Color("mainBg") }
    
    public func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    public func getSafeArea() -> UIEdgeInsets {
        let null = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return null
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return null
        }
        
        return safeArea
    }
    
    public func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
            self.modifier(DeviceRotationViewModifier(action: action))
        }
    
}
