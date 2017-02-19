//
//  Wonders+CoreDataProperties.swift
//  MyWonders
//
//  Created by Ankita Satpathy on 13/02/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import Foundation
import CoreData


extension Wonders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wonders> {
        return NSFetchRequest<Wonders>(entityName: "Wonders");
    }

    @NSManaged public var wonderLatitude: Double
    @NSManaged public var wonderLongitude: Double
    @NSManaged public var wonderName: String?
    @NSManaged public var wonderNotes: String?
    @NSManaged public var wonderShow: Bool
    @NSManaged public var wonderType: String?

}
