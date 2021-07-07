//
//  Photo.swift
//  Project_101112
//
//  Created by PrincePhoenix on 09.06.2021.
//

import Foundation

class Photo: NSObject, Codable {
    var image: String
    var name: String
    
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }
}
