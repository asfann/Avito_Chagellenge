//
//  Employee.swift
//  Avito_Chagellenge
//
//  Created by Asf on 24.10.2022.
//

import Foundation


struct Employee: Codable {
    let name, phoneNumber: String?
    let skills: [String]?

    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
    
    init(avito: AvitoEntity) {
        self.name = avito.name
        self.phoneNumber = avito.phoneNumber
        self.skills = avito.skills
    }
}
