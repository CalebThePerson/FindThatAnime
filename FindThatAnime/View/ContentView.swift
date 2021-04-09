//
//  ContentView.swift
//  AnimeFinderUI
//
//  Created by Caleb Wheeler on 9/17/20.
//

import SwiftUI
import RealmSwift
//Bugs
//WHenever you dismiss without selecting an image it uses teh last saved image??

struct ContentView: View {
    
    @ObservedObject var API = TraceMoeAPI()
    @State private var Anime: Results<AnimeInfo> = realm.objects(AnimeInfo.self)
    @StateObject var animeModel = AnimeInfoViewModel()
    
    @State var SelectedAnime: AnimeInfo?
    
    @State private var DetailViewShowing: Bool = false
    
    var body: some View {
        if Anime.count != 0 {
            GeometryReader { geometry in
                ZStack{
                    ScrollView(.vertical) {
                        VStack(spacing:0) {
                            ForEach(animeModel.theShows, id: \.Id){ anime in
                                Button(action: {
                                    self.SelectedAnime = anime
                                    self.animeModel.selectedShow = anime
                                    self.DetailViewShowing.toggle()
                                }) {
                                    ImageCell(ScreenSize: geometry.size, TheImage: convertBase64ToImage(anime.ImageString))
                                    
                                        
                                    
                                }.sheet(isPresented: self.$DetailViewShowing, onDismiss: {self.DetailViewShowing = false}){
                                    DetailView(Anime: $SelectedAnime, animeModel: animeModel)

                                }
//                                }.onAppear(perform: {
////                                    Testing(with: anime)
//                                })
                            }
                            
                            
                            if API.CirclePresenting == true{
                                LoadingCircle(TheAPI: API)
                                    .padding(.top)
                            }
                        }
                    }
                    .lineSpacing(0)
                    
                    FloatingMenu(TraceAPI: API)
                        .offset(x:150, y:-10)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        
        
        else {
            FloatingMenu(TraceAPI: API)
                .offset(x:150, y:-10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
    
    func Testing(with Anime: AnimeInfo){
        print(Anime)
    }
    
}

