//
//  Item.swift
//  eggplant-brownie
//
//  Created by evo on 06/12/21.
//

import UIKit

class Item: NSObject {
    let nome: String
    let calorias: Double

    init(nome: String, calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }
}
