//
//  CustomAVPlayer.swift
//  PhongFIlm
//
//  Created by PHONG on 15/10/2021.
//

import AVKit
import AVFoundation
import SwiftUI
import UIKit


struct CustomAVPlayer: UIViewControllerRepresentable{
    @Binding var avPlayer: AVPlayer?
    @Binding var isResize: Bool
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        let avPlayerController = AVPlayerViewController()
            
        avPlayerController.player = self.avPlayer!
        
        avPlayerController.showsPlaybackControls = false
        
        avPlayerController.videoGravity = .resize

        return avPlayerController
    }
    
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        uiViewController.player = self.avPlayer!
        uiViewController.videoGravity = self.isResize ? .resizeAspect : .resize
    }
    
}

