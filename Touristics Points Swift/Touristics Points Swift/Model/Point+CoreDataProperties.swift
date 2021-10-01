//
//  Point+CoreDataProperties.swift
//  Touristics Points Swift
//
//  Created by Marta García on 30/9/21.
//
//

import Foundation
import CoreData


extension Point {

    //Recupera todos los datos que tenemos guardados
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Point> {
        return NSFetchRequest<Point>(entityName: "Point")
    }

    @NSManaged public var geocoordinates: String
    @NSManaged public var id: String
    @NSManaged public var title: String

}

extension Point : Identifiable {
    
    static func createWith(id: String, title: String, geocoordinates: String, using viewContext: NSManagedObjectContext) {
        let point = Point(context: viewContext)
        point.id = id
        point.title = title
        point.geocoordinates = geocoordinates
        
        do {
            try viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

}

