import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON
import SwiftUI

class TraceMoeAPI: ObservableObject, showingAlert {
    
    var AniListapi = AniListAPI()
    var animeModel = AnimeInfoViewModel()
    
    @Published var CirclePresenting:Bool = false
    @Published var Percetage:Int = 0
    @Published var DataIsSaved:Bool = false
    @Published var showAlert:Bool = false
    
    func API(ImageString: String){
        CirclePresenting=true
        Percetage = 7
        //Paramerters and Headers
        let myImage = convertBase64ToImage(ImageString)
        let imageData = myImage.jpegData(compressionQuality: 0.50)!
        let kitsuHeaders: HTTPHeaders = [.accept("application/vnd.api+json")]
        var usableTitle  = ""
        
        
        //Uploads the image to the api and making the call
        AF.upload(imageData, to: "https://api.trace.moe/search").responseJSON { response in
            if let jsonData = response.data{
                print("pog")
                let json = try! JSON(data: jsonData)
                //                print(json["result"][0])
                //Creating Variables
                if json["result"][0]["title_english"].string == nil{
                    usableTitle = "title"
                } else {
                    usableTitle = "title_english"
                }
                guard let episode = json["result"][0]["episode"].int else {return}
                guard let AnilistId = json["result"][0]["anilist"].int else {return}
                guard let Similarity = json["result"][0]["similarity"].double else {return}
                print("welp")
                
                self.AniListapi.ObtainData(AnimeID: AnilistId) { NewData in
                    let cleanData = self.Disection(TheData: NewData)
                    let info = AnimeInfo()
                    let url = URL(string: cleanData["coverImage"] as! String)
                    let data = try? Data(contentsOf: url!)
                    let image: UIImage = UIImage(data: data!)!
                    
                    info.Name = cleanData["title"] as! String
                    info.Episode = episode
                    info.MalID = cleanData["malId"] as! Int
                    info.AniListID = AnilistId
                    info.ImageString = ImageString
                    info.pictureUrl = self.convertImageToBase64(image)
                    info.Description = cleanData["Description"] as! String
                    info.Similarity = Similarity * 100
                    info.Id = UUID().uuidString
                    
                    
                    for genre in NewData.media?.genres as [String]{
                        let RealmGenres = Genres()
                        RealmGenres.genre = genre
                        info.genres.append(RealmGenres)
                    }
                    
                    self.animeModel.addShow(theShow: info)
                    self.DataIsSaved = true
                    self.CirclePresenting = false
                    
                }
            }
        }
        
    }
}

extension TraceMoeAPI {
    
    func Disection(TheData: QueryQuery.Data) -> [(String):(Any)] {

        var Poggers = [(String):(Any)]()
        //Loping through and removing the annoying <b> and what not
        var Description = (TheData.media?.description)! as String
        let removale = ["<br> <br>", "<br>", "<b/>", "<br><br>","</b>","<i>","</i>","<b>"]

        
        for word in removale{
            Description = Description.replacingOccurrences(of: word, with: "")
        }

        let StartDate = TheData.media?.startDate
        let Populatiry = TheData.media?.popularity
        let SiteUrl = TheData.media?.siteUrl
        let title = TheData.media?.title?.english
        let coverImage = TheData.media?.coverImage?.extraLarge
        let malId = TheData.media?.idMal

        Poggers["Description"] = Description
        Poggers["Popularity"] = Populatiry
        Poggers["SiteURL"] = SiteUrl
        Poggers["title"] = title
        Poggers["coverImage"] = coverImage
        Poggers["malId"] = malId

        return Poggers

    }
    
    func convertBase64ToImage(_ str: String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
    func convertImageToBase64(_ image: UIImage) -> String {
            let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            return strBase64
        }
}
