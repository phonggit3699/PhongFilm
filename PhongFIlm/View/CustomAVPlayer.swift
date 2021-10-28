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
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        let avPlayerController = AVPlayerViewController()
            
        avPlayerController.player = self.avPlayer!
        
        avPlayerController.showsPlaybackControls = false
        
        avPlayerController.videoGravity = .resizeAspectFill

        return avPlayerController
    }
    
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        uiViewController.player = self.avPlayer!
    }
    
}

