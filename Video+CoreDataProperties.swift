//
//  Video+CoreDataProperties.swift
//  MyWonders
//
//  Created by Ankita Satpathy on 13/02/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video");
    }

    @NSManaged public var wonderName: String?
    @NSManaged public var wonderVideoUrl: String?

}
