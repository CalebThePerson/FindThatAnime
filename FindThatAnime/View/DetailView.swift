//
//  DetailView.swift
//  FindThatAnime
//
//  Created by Caleb Wheeler on 9/26/20.
//

import SwiftUI
import URLImage

struct DetailView: View {
    @Binding var Anime: AnimeInfo?
    var animeModel: AnimeInfoViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical){
                VStack{
                    //Creating a group because i apparently can't have more than 10 views -_-
                    Group {
                        Spacer()
                        Text(animeModel.name)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(alignment:.center)
                        
                        
                        Text("Episode:\(animeModel.episode)")
                            .frame(alignment:.center)
                        
                        HStack{
                            Text("Similarity:\(animeModel.similarity, specifier: "%.f")%")
                                .frame(alignment: .center)
                            
                            switch animeModel.color{
                            case .green:
                                Image(systemName: "square.fill")
                                    .foregroundColor(Color(.green))
                                
                            case .yellow:
                                Image(systemName: "square.fill")
                                    .foregroundColor(Color(.yellow))
                                
                            case .red:
                                Image(systemName: "square.fill")
                                    .foregroundColor(Color(.red))
                            }
                        }
                        
                        Imagesub(Screensize: geometry.size, DaImage: convertBase64ToImage(animeModel.imageString))
                            .frame(alignment:.center)
                        
                        Spacer()
                        Text("Description")
                        Text(animeModel.description)
                            .multilineTextAlignment(.center)
                            .frame(width: geometry.size.width - 20)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom)
                        
                        
                        GenreView(GenreArray: animeModel.genres)
                            .padding(.bottom)
                        
                    }
                    
                    Text("Likes: \(animeModel.popularity)")
                    
                }
            }
            .background(URLImage(url: URL(string:animeModel.pictureLink)!){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    
                    
            }.opacity(0.2)
            .ignoresSafeArea())
        }
        
        
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(Anime: .constant(AnimeInfo()))
//    }
//}

extension DetailView{
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
}
