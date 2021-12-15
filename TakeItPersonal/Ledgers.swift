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
    @objc dynamic var date: String = ""
    @objc dynamic var notes: String = ""
//    @objc dynamic var sumTotal: Double = 0.0 
    
    var parentCategory = LinkingObjects(fromType: Months.self, property: "ledger")

    
}
