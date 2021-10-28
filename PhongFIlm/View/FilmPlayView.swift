//
//  FilmPlayView.swift
//  PhongFIlm
//
//  Created by PHONG on 17/10/2021.
//

import SwiftUI
import AVFoundation
import AVKit

struct FilmPlayView: View {
    
    @State private var avPlayer: AVPlayer?
    @State private var currentIndex: Int = 0
    @State private var isPlaying: Bool = false
    @State private var showButtonHide: Bool = false
    @State private var isShowPlayBack: Bool = false
    @State private var isFullScreen: Bool = false
    
    @Binding var filmURL: [URL?]
    @Binding var isPlayFilm: Bool
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        VStack {
            
            // Player frame
            ZStack{
                if self.avPlayer != nil {
                    
                    CustomAVPlayer(avPlayer: self.$avPlayer)
                        .onTapGesture {
                            self.isShowPlayBack.toggle()
                        }
                    CustomPlayBack(isPlaying: self.$isPlaying,avPlayer: self.$avPlayer, isPlayFilm: self.$isPlayFilm, isShowPlayBack: self.$isShowPlayBack, isFullScreen: self.$isFullScreen)
                    
                }
                else{
                    Rectangle()
                        .fill(Color.gray)
                }
            }
            // TODO: tranfrom avplayer to lanscape and full screen
            .rotationEffect(self.isFullScreen ? .degrees(90) : .zero)
            .frame(width: self.isFullScreen ? getRect().height : nil, height: self.isFullScreen ? getRect().width: isSmallScreen ? 200 : 250)
            .offset(y: self.isFullScreen ? getOffsetFilmPlayWhenFullScreen() : 0)
            .onRotate { newOrientation in
                orientation = newOrientation
            }
            .onChange(of: self.orientation, perform: { value in
                if value.isLandscape {
                    self.isFullScreen = true
                }else{
                    self.isFullScreen = false
                }
            })
        }
        .frame(maxWidth: getRect().width, maxHeight: .infinity, alignment: .top)
        .background(
            Color("bg1")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        )
        .ignoresSafeArea()
        .statusBar(hidden: self.isFullScreen)
        .onAppear{
            if let currentFilmURL: URL = filmURL[currentIndex] {
                self.avPlayer = AVPlayer(url: currentFilmURL)
                if self.isPlaying == false {
                    self.avPlayer?.play()
                    self.isPlaying = true
                }
                
            }
        }
        .onDisappear{
            // Pause film when hide this view
            if self.isPlaying == true {
                self.avPlayer?.pause()
                self.isPlaying = false
            }
        }
    }
}

// TODO: Custom Playback
struct CustomPlayBack: View {
    
    @Binding var isPlaying: Bool
    @Binding var avPlayer: AVPlayer?
    @Binding var isPlayFilm: Bool
    @Binding var isShowPlayBack: Bool
    @Binding var isFullScreen: Bool
    @State private var value: CGFloat = 0
    
    var body: some View{
        ZStack {
            VStack{
                
                // TODO: Hide filmplayview button
                HStack {
                    Button(action: {
                        self.isPlayFilm.toggle()
                    }, label: {
                        Image(systemName: "chevron.compact.down")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 18, height: 8)
                    })
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, getSafeArea().top)
                Spacer()
            }
            
            // //TODO: mid bar
            HStack(spacing: 40){
                
                // TODO: Seek 10 second Button
                Button(action: {
                    self.avPlayer?.seek(to: CMTime(seconds: getCurrentSecond() + 10, preferredTimescale: 1))
                    
                }, label: {
                    Image(systemName: "goforward.10")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 22, height: 25)
                })
                
                // TODO: Play pause Button
                if value == 1 {
                    Button(action: {
                        self.avPlayer?.seek(to: CMTime.zero)
                        self.avPlayer?.play()
                        self.isPlaying = true
                    }, label: {
                        Image(systemName: "goforward")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 32)
                    })
                }
                else{
                    Button(action: {
                        if self.isPlaying == false {
                            self.avPlayer?.play()
                            self.isPlaying = true
                        }
                        else{
                            self.avPlayer?.pause()
                            self.isPlaying = false
                        }
                        
                    }, label: {
                        Image(systemName: self.isPlaying ? "pause.fill" : "play.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 22, height: 25)
                    })
                }
                
                // TODO: Seek 10 second Button
                Button(action: {
                    self.avPlayer?.seek(to: CMTime(seconds: getCurrentSecond() - 10, preferredTimescale: 1))
                    
                }, label: {
                    Image(systemName: "gobackward.10")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 22, height: 25)
                })
            }
            //TODO: Bottom bar
            VStack{
                
                Spacer()
                
                HStack(spacing: 10) {
                    CustomSlider(value: self.$value, avPlayer: self.$avPlayer, isFullScreen: self.$isFullScreen)
                    
                    Button(action: {
                        withAnimation {
                            self.isFullScreen.toggle()
                        }
                        
                    }, label: {
                        Image(self.isFullScreen ? "normalscreen" : "fullscreen")
                            .resizable()
                            .frame(width: 25, height: 25)
                    })
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .frame(maxWidth: self.isFullScreen ? getRect().height :  getRect().width)
                .background(Color.black.opacity(0.8).clipShape(Capsule()))
                .padding()
            }
            
        }
        .frame(width: self.isFullScreen ? getRect().height : nil, height: self.isFullScreen ? getRect().width : nil)
        .ignoresSafeArea()
        .background(Color.gray.opacity(0.1))
        .opacity(self.isShowPlayBack ? 1 : 0)
        .onAppear{
            self.avPlayer?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1.0, preferredTimescale: 1), queue: .main, using: { _ in
                guard let currentSecond = self.avPlayer?.currentTime().seconds else {
                    return
                }
                self.value = CGFloat(currentSecond / (self.avPlayer?.currentItem?.duration.seconds)!)
                
                if value == 1.0 {
                    self.isPlaying.toggle()
                }
            })
        }
        .onChange(of: self.avPlayer, perform: { _ in
            self.avPlayer?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1.0, preferredTimescale: 1), queue: .main, using: { _ in
                guard let currentSecond = self.avPlayer?.currentTime().seconds else {
                    return
                }
                self.value = CGFloat(currentSecond / (self.avPlayer?.currentItem?.duration.seconds)!)
                
                if value == 1.0 {
                    self.isPlaying.toggle()
                }
            })
        })
        .onChange(of: self.isShowPlayBack, perform: { value in
//            if value == true {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                    self.isShowPlayBack.toggle()
//                }
//            }
        })
    }
}

extension FilmPlayView {
    
    func selectEpisode(index: Int){
        self.avPlayer?.pause()
        self.isPlaying = false
        self.currentIndex = index
        guard let currentFilmURL: URL = self.filmURL[self.currentIndex] else{
            return
        }
        
        self.avPlayer = AVPlayer(url: currentFilmURL)
        
        self.avPlayer?.play()
        
        self.isPlaying = true
        
        
    }
    
    func nextVideo() {
        if self.currentIndex < self.filmURL.count - 1 {
            self.currentIndex += 1
            guard let currentFilmURL: URL = self.filmURL[self.currentIndex] else{
                return
            }
            
            self.avPlayer = AVPlayer(url: currentFilmURL)
            
            self.avPlayer?.play()
        }
    }
    
    func previousVideo() {
        if self.currentIndex > 0 {
            self.currentIndex -= 1
            guard let currentFilmURL: URL = self.filmURL[self.currentIndex] else{
                return
            }
            
            self.avPlayer = AVPlayer(url: currentFilmURL)
            
            self.avPlayer?.play()
        }
    }
    
    func getOffsetFilmPlayWhenFullScreen() -> CGFloat{
        return (getRect().height - getRect().width) / 2
    }
}

extension CustomPlayBack {
    func getCurrentSecond() -> Double{
        return Double( Double(self.value) * (self.avPlayer?.currentItem?.duration.seconds)! )
    }
}

struct FilmPlayView_Previews: PreviewProvider {
    static var previews: some View {
        FilmPlayView(filmURL: .constant(urlDemo), isPlayFilm: .constant(false))
    }
}

