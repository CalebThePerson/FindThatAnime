//
//  GenreView.swift
//  FindThatAnime
//
//  Created by Caleb Wheeler on 10/15/20.
//

import SwiftUI
import RealmSwift

struct GenreView: View {
    var GenreArray: RealmSwift.List<Genres>
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(0..<GenreArray.count) { genre in
                        Spacer()
                        ZStack{
                            Text(GenreArray[genre].genre)
                            

                        }
                        Spacer()
                    }
                }
            }
            .frame(height: 20 ,alignment: .center)
        }
    }
}

struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        GenreView(GenreArray: AnimeInfo().genres)
    }
}


