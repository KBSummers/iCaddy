//
//  Favorite+CoreDataProperties.swift
//  iCaddy
//
//  Created by Kyle Summers on 4/21/20.
//  Copyright © 2020 Kyle Summers. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorite {
/*
     
     
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }
*/
    @NSManaged public var name: String?
    @NSManaged public var rating: Double

}
