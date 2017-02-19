//
//  Sound+CoreDataProperties.swift
//  MyWonders
//
//  Created by Ankita Satpathy on 13/02/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import Foundation
import CoreData


extension Sound {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sound> {
        return NSFetchRequest<Sound>(entityName: "Sound");
    }

    @NSManaged public var wonderName: String?
    @NSManaged public var wonderSoundTitle: String?
    @NSManaged public var wonderSoundUrl: String?

}
