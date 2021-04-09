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
        let MyParameters = ["image":"\(ImageString)"]
        let Headers: HTTPHeaders = [.accept("application/json")]
        let kitsuHeaders: HTTPHeaders = [.accept("application/vnd.api+json")]
        var usableTitle  = ""
        
        //Actually Making the request
        AF.request("https://trace.moe/api/search", method:.post, parameters: MyParameters, headers: Headers).responseJSON { [self] response in
            
            Percetage = 14
            print("Working")
            
            if let Data = response.data{
                print("come on")
                //Creates the JSON Files
                let json = try! JSON(data: Data)
                print(json["docs"][0])
                
                print("Almost there")
                Percetage = 21

                
                //Creatinug our variables taht we want to save
                print("start")
                if json["docs"][0]["title_english"].string == nil{
                    usableTitle = "title"
                } else{
                    usableTitle = "title_english"
                }
                
                guard let name = json["docs"][0][usableTitle].string else {return; self.showAlert = true}
                print("Boom")
                guard let episode = json["docs"][0]["episode"].int else {return}
                Percetage = 28
                guard let AnilistId = json["docs"][0]["anilist_id"].int else {return}
                guard let MalID = json["docs"][0]["mal_id"].int else {return}
                guard let Similarity = json["docs"][0]["similarity"].double else {return}
                Percetage = 35
                
                //The Video Variables
                guard let at = json["docs"][0]["at"].int else {return}
                guard let filename = json["docs"][0]["filename"].string else {return}
                guard let tokenthumb = json["docs"][0]["tokenthumb"].string else {return}
                
                Percetage = 42
                var kitsuName = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                print(kitsuName)
                
                AF.request("https://kitsu.io/api/edge/anime?filter[text]=\(kitsuName))", method:.get, headers: kitsuHeaders).responseJSON { kitsuResponse in
                    print(kitsuResponse)
                    if let kitsuData = kitsuResponse.data {
                        print("testing")

                        let kitsuJson = try! JSON(data: kitsuData)
                        
                        print("here??")
                        guard let pictureURL = kitsuJson["data"][0]["attributes"]["posterImage"]["original"].string else {return}
                        print(pictureURL)
                        
                        self.AniListapi.ObtainData(AnimeID: AnilistId) { (NewData) in
                            
                            
                            let TheStuff = self.Disection(TheData: NewData)
                            let Info = AnimeInfo()
                            Percetage = 49
                            Info.Name = name
                            Percetage = 56
                            Info.Episode = episode
                            Percetage = 63
                            Info.MalID = MalID
                            Percetage = 70
                            Info.AniListID = AnilistId
                            Percetage = 77
                            Info.ImageString = ImageString
                            Percetage = 84
                            Info.VideoURL = "https://media.trace.moe/video/$\(AnilistId)/${encodeURIComponent\(filename)}?t=$\(at)&token=$\(tokenthumb)"
                            Percetage = 91
                            Info.pictureUrl = pictureURL
                            
                            Info.Similarity = Similarity * 100
                            print(Similarity)
                            //Looping through the genres and adding it
                            for genre in NewData.media?.genres as [String]{
                                let RealmGenres = Genres()
                                RealmGenres.genre = genre
                                Info.genres.append(RealmGenres)
                            }
                            
                            Info.Description = TheStuff["Description"] as! String
                            Info.Popularity = TheStuff["Popularity"] as! Int
                            
                            //Giving it a unique id so that it doesn't break when using the same name anime
                            Info.Id = UUID().uuidString
                            
                            
                            self.animeModel.addShow(theShow: Info)
                            Percetage = 100
                            print("Done")
                            self.DataIsSaved = true
                            self.CirclePresenting = false
                            
                            print("https://media.trace.moe/video/${\(AnilistId)}/${encodeURIComponent(\(filename))}?t=${\(at)}&token=$\(tokenthumb)")
                        }
                    }
                    
                }
                
            }
            
            //https://media.trace.moe/video/${anilist_id}/${encodeURIComponent(filename)}?t=${at}&token=${tokenthumb}`
            
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
        
        Poggers["Description"] = Description
        Poggers["Popularity"] = Populatiry
        Poggers["SiteURL"] = SiteUrl
        
        return Poggers
        
    }
    
    
}
