//
//  AnimeInfoViewModel.swift
//  FindThatAnime
//
//  Created by Caleb Wheeler on 4/8/21.
//

import Foundation
import RealmSwift
import Combine

enum colorSquare:Identifiable{
    var id: Int{
        hashValue
    }
    
    case green
    case yellow
    case red
}

class AnimeInfoViewModel: ObservableObject{
    var theShow: AnimeInfo? = nil
    var realm: Realm?
    var token: NotificationToken? = nil
    
    
    @ObservedResults(AnimeInfo.self) var theShows
    
    @Published var deleting:Bool = false
    @Published var selectedShow: AnimeInfo? = nil
    
    init(){
        let realm = try? Realm()
        self.realm = realm
        
        token = theShows.observe({ (changes) in
            switch changes{
            case .error(_):break
            case .initial(_): break
            case .update(_, deletions: _, insertions: _, modifications: _):
                self.objectWillChange.send()            }
        })
    }
    
    deinit {
        token?.invalidate()
    }
    
    var name: String{
        get{
            selectedShow!.Name
        }
    }
    
    var id: String{
        get {
            selectedShow!.Id
        }
    }
    
    var imageString:String {
        get {
            selectedShow!.ImageString
        }
    }
    
    var episode:Int {
        get {
            selectedShow!.Episode
        }
    }
    
    var anilistId: Int{
        get{
            selectedShow!.AniListID
        }
    }
    
    var malId: Int {
        get {
            selectedShow!.MalID
        }
    }
    
    var videoUrl:String {
        get{
            selectedShow!.VideoURL
        }
    }
    
    var description: String {
        get {
            selectedShow!.Description
        }
    }
    
    var popularity: Int{
        get {
            selectedShow!.Popularity
        }
    }
    
    var siteurl: String{
        get {
            selectedShow!.SiteURL
        }
    }
    
    var similarity: Double{
        get {
            selectedShow!.Similarity
        }
    }
    
    var genres: List<Genres>{
        get {
            selectedShow!.genres
        }
    }
    var color:colorSquare{
        get{
            switch selectedShow!.Similarity{
            case 0...50:
                return .red
            case 50...75:
                return .yellow
            case 75...100:
                return .green
            default:
                return .green
            }
        }
    }
    
    var pictureLink:String{
        get {
            selectedShow!.pictureUrl
        }
    }
    
    func deleteShow(){
            try? realm?.write{
                realm?.delete(selectedShow!)
            }
        deleting = false
    }
    
    func addShow(theShow: AnimeInfo){
        try? realm?.write({
            realm?.add(theShow)
        })
    }

}
