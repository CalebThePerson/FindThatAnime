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
    @State var deleteAlert:Bool = false
    @Environment(\.presentationMode) var presentationMode

    
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
                        
                        
                        Image(uiImage: convertBase64ToImage(animeModel.imageString))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.horizontal, 20)
                        
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
                //Overlay for the delete button
                .overlay(
                    VStack{
                        HStack{
                            Button(action:{
                                self.deleteAlert.toggle()
                            }){
                                Image(systemName: "trash.circle")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 25, height: 25)
                            }
                            .padding([.top,.leading], 20)
                        }
                    }, alignment: .topLeading)
            }
            
            //Alert that shows the view and says we can delete it or not
            .alert(isPresented: $deleteAlert){
                Alert(title: Text("Would you like to delete this entery"), message: Text(animeModel.name), primaryButton: .default(Text("Delete")){
                    animeModel.deleting = true
                    presentationMode.wrappedValue.dismiss()
                }, secondaryButton: .cancel())
            }
            .background(URLImage(URL(string:animeModel.pictureLink)!){ image in
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
