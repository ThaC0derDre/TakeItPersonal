//
//  Ledgers.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/10/21.
//

import Foundation
import RealmSwift

class Ledgers: Object {
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var date: Date = Date()
    @objc dynamic var notes: String?
    
    var parentCategory = LinkingObjects(fromType: Months.self, property: "ledger")

    
}
