//
//  TestingWithList.swift
//  FindThatAnime
//
//  Created by Caleb Wheeler on 9/24/20.
//

import SwiftUI
import RealmSwift



struct TestingWithList: View {
    @ObservedObject var API = TraceMoeAPI()
    @State private var Anime: Results<AnimeInfo> = realm.objects(AnimeInfo.self)
    @State private var Showing = false
    
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                VStack(alignment: .center, spacing: 0) {
                    List(Anime){
                        anime in
                        Button(action: {
                            self.Showing = true
                        }) {
                            ImageCell(ScreenSize: geometry.size, TheImage: convertBase64ToImage(anime.ImageString))
                        } .sheet(isPresented: self.$Showing, onDismiss: {self.Showing = false}) {
                        }
                        if API.CirclePresenting == true {
                            LoadingCircle(TheAPI: API)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    
                }
                FloatingMenu(TraceAPI: API)
                    .offset(x: 150, y:-10)
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct TestingWithList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TestingWithList()
            TestingWithList()
        }
    }
}

extension TestingWithList {
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
}
