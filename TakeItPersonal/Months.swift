//
//  Months.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/10/21.
//

import Foundation
import RealmSwift

class Months: Object {
    @objc dynamic var months = ""
    let ledger = List<Ledgers>()
    
}
