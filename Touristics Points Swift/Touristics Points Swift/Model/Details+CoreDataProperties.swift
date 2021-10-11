//
//  Details+CoreDataProperties.swift
//  Touristics Points Swift
//
//  Created by Marta García on 30/9/21.
//
//

import CoreData


extension Details {
    
    //Recupera todos los datos que tenemos guardados
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Details> {
        return NSFetchRequest<Details>(entityName: "Details")
    }

    @NSManaged public var address: String
    @NSManaged public var descriptionPlace: String
    @NSManaged public var email: String
    @NSManaged public var geocoordinatesDetail: String
    @NSManaged public var idDetail: String
    @NSManaged public var phone: String
    @NSManaged public var titleDetail: String
    @NSManaged public var transport: String

}

extension Details : Identifiable {
    
    static func createWith(id: String, title: String, geocoordinates: String, address: String, description: String, email: String, phone: String, transport: String, using viewContext: NSManagedObjectContext) {
        let detail = Details(context: viewContext)
        detail.idDetail = id
        detail.titleDetail = title
        detail.geocoordinatesDetail = geocoordinates
        detail.address = address
        detail.descriptionPlace = description
        detail.email = email
        detail.phone = phone
        detail.transport = transport

        do {
            try viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

}
