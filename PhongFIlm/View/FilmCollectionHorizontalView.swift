//
//  FilmCollectionHorizontalView.swift
//  PhongFIlm
//
//  Created by PHONG on 19/10/2021.
//

import SwiftUI

struct FilmCollectionHorizontalView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Phim bo")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Tat ca")
                        .font(.body)
                        .foregroundColor(.gray)
                })
            }.padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing: 15) {
                    ForEach(datas){data in
                        CardFilmHorizontal(film: CardFilmModel(imageName: data.img, title: data.name))
                    }
                }.padding(.horizontal)
            })
        }
        .padding(.top, 5)
    }
}

struct FilmCollectionHorizontalView_Previews: PreviewProvider {
    static var previews: some View {
        FilmCollectionHorizontalView()
    }
}

struct CardFilmHorizontal: View{
    
    var film: CardFilmModel
    
    @State private var isPlayFilm: Bool = false
    
    @State private var filmUrl: [URL?] = [nil]
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.isPlayFilm.toggle()
            }
        }, label: {
            VStack(spacing: 5){
                Image(film.imageName)
                    .resizable()
                    .frame(width: isSmallScreen ? 160 : 180, height: isSmallScreen ? 100 : 110)
                    .cornerRadius(5)
                
                Text(film.title)
                    .foregroundColor(.white)
                    .font(isSmallScreen ? .caption : .callout)
            }
            .fullScreenCover(isPresented: self.$isPlayFilm, content: {
                FilmPlayView(filmURL: self.$filmUrl, isPlayFilm: self.$isPlayFilm)
            })
            .onAppear{
                self.filmUrl = urlDemo
            }
        })
        
    }
}
