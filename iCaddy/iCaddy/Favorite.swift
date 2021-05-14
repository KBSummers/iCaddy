//
//  Favorite.swift
//  iCaddy
//
//  Created by Kyle Summers on 4/21/20.
//  Copyright © 2020 Kyle Summers. All rights reserved.
//

import UIKit
import CoreData

class Favorite: NSManagedObject {
    @NSManaged public var name:String?
    @NSManaged public var rating:Double?

}
