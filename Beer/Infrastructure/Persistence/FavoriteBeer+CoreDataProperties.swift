//
//  FavoriteBeer+CoreDataProperties.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation
import CoreData

extension FavoriteBeer {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteBeer> {
        return NSFetchRequest<FavoriteBeer>(entityName: "FavoriteBeer")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var desc: String
    @NSManaged public var imageName: String
    
}

extension FavoriteBeer: Identifiable {}

