//
//  Ledgers.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/10/21.
//

import Foundation
import RealmSwift

class Ledgers: Object {
    @objc dynamic var entry = ""
    var parentCategory = LinkingObjects(fromType: Months.self, property: "ledger")

    
}
