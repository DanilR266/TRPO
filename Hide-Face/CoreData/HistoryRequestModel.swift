//
//  CoreDataModel.swift
//  Hide-Face
//
//  Created by Данила on 17.04.2024.
//

import Foundation
import CoreData

@objc(CoreDataModel)
public class CoreDataModel: NSManagedObject { }

extension CoreDataModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataModel> {
        return NSFetchRequest<CoreDataModel>(entityName: "HistoryRequest")
    }
    
    @NSManaged public var date: String
    @NSManaged public var data: Data?
    @NSManaged public var type1: String
    @NSManaged public var type2: String
    @NSManaged public var type3: String
    @NSManaged public var type4: String
    @NSManaged public var type5: String
    @NSManaged public var id: String
    @NSManaged public var isoDate: String
}

extension CoreDataModel : Identifiable {}
