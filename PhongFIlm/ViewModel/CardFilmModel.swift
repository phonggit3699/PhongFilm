//
//  CardFilmModel.swift
//  PhongFIlm
//
//  Created by PHONG on 19/10/2021.
//

import SwiftUI

struct CardFilmModel: Identifiable, Codable {
    var id = UUID().uuidString
    var imageName: String
    var title: String
}
