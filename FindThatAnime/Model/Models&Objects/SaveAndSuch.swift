//
//  SaveAndSuch.swift
//  AnimeFinder
//
//  Created by Caleb Wheeler on 9/5/20.
//  Copyright © 2020 Caleb Wheeler. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()


func Save(Anime: AnimeInfo) {
    do {
        try realm.write {
            realm.add(Anime)
        }
        
    } catch {
        print("The erorr is \(error)")
    }
    print("Saved")
}




