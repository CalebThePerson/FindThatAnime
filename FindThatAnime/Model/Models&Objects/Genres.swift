//
//  Genres.swift
//  FindThatAnime
//
//  Created by Caleb Wheeler on 10/15/20.
//

import Foundation
import RealmSwift

class Genres: Object {
    @objc dynamic var genre: String = ""
    var ParenAnime = LinkingObjects(fromType: AnimeInfo.self, property: "genres")
}
