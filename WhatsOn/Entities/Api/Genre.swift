//
//  Genre.swift
//  What'sOn
//
//  Created by Maxime Maheo on 26/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct GenreList: Decodable {
    
    let genres: [Genre]
    
}

struct Genre: Codable {
    
    let id: Int
    let name: String
    
}

extension Genre {
    
    var smiley: String {
        switch id {
        case 28:
            return "👊"
        case 16:
            return "👶"
        case 99:
            return "🧠"
        case 36:
            return "🕰"
        case 10770:
            return "📺"
        case 10752:
            return "⚔️"
        case 12:
            return "🤠"
        case 35:
            return "😂"
        case 80:
            return "🔪"
        case 27:
            return "😰"
        case 10402:
            return "🎹"
        case 10749:
            return "😍"
        case 14:
            return "🦄"
        case 18:
            return "😭"
        case 10751:
            return "👨‍👩‍👧‍👦"
        case 9648:
            return "🤔"
        case 878:
            return "🤖"
        case 53:
            return "😬"
        case 37:
            return "🐴"
        default:
            return ""
        }
    }
    
}
