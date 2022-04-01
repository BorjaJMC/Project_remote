//
//  Userdata.swift
//  Proyecto
//
//  Created by Borja Martín on 9/3/22.
//

import Foundation


struct ApiData: Codable {
    
    var page: Int
    var results: [FilmData]
}

struct FilmData: Codable {
    
    var id: Int
    var backdrop_path: String
    var overview: String
    var poster_path: String
    var title: String
    
}

