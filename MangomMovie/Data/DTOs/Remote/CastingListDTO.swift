//
//  CastingListDTO.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import Foundation

struct CastingListDTO: Decodable {
    let cast: [ActorDTO]
    let crew: [CrewDTO]
}

struct ActorDTO: Decodable {
    let name: String
}

struct CrewDTO: Decodable {
    let name: String
    let department: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case department = "known_for_department"
    }
}
