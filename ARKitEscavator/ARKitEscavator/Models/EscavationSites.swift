//
//  EscavationSite.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 25/06/25.
//

import Foundation
import CoreLocation

struct MajorSite: Decodable {
    let id: Int
    let name: String
    let description: String
    let completed: Bool
    var image: String?
    let escavationPoints: [EscavationPoint]
    
    init(id: Int, name: String, description: String, completed: Bool, image: String? = nil, escavationPoints: [EscavationPoint]) {
        self.id = id
        self.name = name
        self.description = description
        self.completed = completed
        self.image = image
        self.escavationPoints = escavationPoints
    }
    
    init() {
        self.id = 0
        self.name = "Praça do Ferreira"
        self.description = "Um dos pontos históricos mais tradicionais de Fortaleza, com grande valor cultural."
        self.completed = false
        self.image = nil
        self.escavationPoints = [.init()]
    }
}

struct EscavationPoint: Decodable {
    let id: Int
    let name: String
    let shortDescription: String
    let longDescription: String
    let object3DModel: String
    let objectImage: String
    let address: String
    let escavated: Bool
    let coordinates: CLLocationCoordinate2D

    private enum CodingKeys: String, CodingKey {
        case id, name, shortDescription, longDescription, object3DModel, objectImage, address, escavated, coordinates
    }

    private enum CoordinatesKeys: String, CodingKey {
        case latitude, longitude
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        shortDescription = try container.decode(String.self, forKey: .shortDescription)
        longDescription = try container.decode(String.self, forKey: .longDescription)
        object3DModel = try container.decode(String.self, forKey: .object3DModel)
        objectImage = try container.decode(String.self, forKey: .objectImage)
        address = try container.decode(String.self, forKey: .address)
        escavated = try container.decode(Bool.self, forKey: .escavated)

        let coordinatesContainer = try container.nestedContainer(keyedBy: CoordinatesKeys.self, forKey: .coordinates)
        let latitude = try coordinatesContainer.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try coordinatesContainer.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init() {
        self.id = 1
        self.name = "Relógio da Praça do Ferreira"
        self.shortDescription = "O relógio da Praça do Ferreira é um dos símbolos mais conhecidos de Fortaleza, instalado em 1933."
        self.longDescription = "Estrutura erguida no século XX como símbolo da modernização urbana da cidade. O relógio da Praça do Ferreira é um marco arquitetônico de grande importância cultural."
        self.object3DModel = "relogio_ferreira_3d.usdz"
        self.objectImage = "RelogioPracaFerreira"
        self.address = "R. Floriano Peixoto - Centro, Fortaleza - CE."
        self.escavated = false
        self.coordinates = CLLocationCoordinate2D(latitude: -3.7304, longitude: -38.5210)
    }
}

extension MajorSite {
    static func loadAllMajorSites() -> [MajorSite] {
        guard let url = Bundle.main.url(forResource: "escavation_sites", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return []
        }

        let decoder = JSONDecoder()
        do {
            return try decoder.decode([MajorSite].self, from: data)
        } catch {
            print("Erro ao decodificar JSON: \(error)")
            return []
        }
    }
}
