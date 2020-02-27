//
//  Section.swift
//  What'sOn
//
//  Created by Maxime Maheo on 25/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

enum SectionDisplayType {
    case featured, standard
}

enum SectionContentType {
    case popular, discover, topRated, nowPlaying, upcoming
}

struct Section {
    let title: String
    let displayType: SectionDisplayType
    let content: SectionContentType
}
