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

protocol showingAlert{
    var showAlert:Bool {get set}
}

struct ContentView: View {
    
    @ObservedObject var API = TraceMoeAPI()
    @StateObject var animeModel = AnimeInfoViewModel()
    
    @State var SelectedAnime: AnimeInfo?
    @State private var DetailViewShowing: Bool = false
    
    @State var showAlert:Bool = false
    
    var body: some View {
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
                                
                                
                                
                            }.sheet(isPresented: self.$DetailViewShowing, onDismiss: {if animeModel.deleting == true {animeModel.deleteShow()}}){
                                DetailView(Anime: $SelectedAnime, animeModel: animeModel)
                            }
                            
                            
                            
                        }
                        if API.CirclePresenting == true{
                            LoadingCircle(TheAPI: API)
                                .padding(.top, 5)
                        }
                        
                        
                        
                    }
                    
                }
                .overlay(
                    VStack{
                        HStack{
                            FloatingMenu(TraceAPI: API)
                                .padding(.bottom, 30)
                                .padding(.horizontal, 300)
                        }
                    }, alignment: .bottomLeading)
                
                .overlay(
                    VStack{
                        HStack{
                            
                        }
                    }, alignment: .center)
                
                .lineSpacing(0)
                
            }
        }
        .alert(isPresented: $API.showAlert, content: {
            Alert(title: Text("Sorry"), message: Text("We couldn't find the anime"), dismissButton: .cancel())
        })
        .edgesIgnoringSafeArea(.all)
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

