////
////  DetailView.swift
////  Touristics Points Swift
////
////  Created by Marta García on 13/9/21.
////

import SwiftUI
import CoreData

struct DetailView: View {
    
    @Binding var idP: String
    
    var body: some View {
        
        DetailPlace(idP: $idP)
    }
}



struct DetailPlace: View {
    
    @State var pointDetail: DetailViewModel?
    @Binding var idP: String
    
    
    var body: some View {
        ScrollView {
            VStack {
                if let detail = pointDetail{
                    
                    Text(detail.title)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .frame(maxHeight: .infinity)
                    
                    VStack{
                        MapView(pointDetail: pointDetail)
                            .frame(height: 300)
                    }
                    
                    Text(detail.address)
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                        .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .padding()
                    
                    HStack{
                        Image(systemName: "envelope.fill")
                            .resizable()
                            .foregroundColor(Color.blue)
                            .frame(width:25.0, height: 20.0)
                        Text(detail.email)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                    }
                    
                    HStack{
                        Image(systemName: "phone.fill")
                            .resizable()
                            .foregroundColor(Color.blue)
                            .frame(width: 20, height: 20)
                        Text(detail.phone)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Text(detail.description)
                        .font(.body)
                        .padding([.top, .leading, .trailing])
                }
            }
        }.onAppear(perform: getDetailPoint)
        
    }
    
    func getDetailPoint() {
        
        let urlDetailPOI = URL(string: "http://t21services.herokuapp.com/points/\(idP)")! //Pasar ID que queremos mostrar
        var request = URLRequest(url: urlDetailPOI)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlDetailPOI) { data, response, error in
            if let data = data {
                if let dpoints = try? JSONDecoder().decode(DetailViewModel.self, from: data) {
                    self.updateContext(dpoints: dpoints)
                } else {
                    print("Invalid Response")
                    self.getDetailFromCoreData()
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            
        }
        task.resume()
    }
    
    func updateContext(dpoints: DetailViewModel) {
        Details.createWith(id: dpoints.id, title: dpoints.title, geocoordinates: dpoints.geocoordinates, address: dpoints.address, description: dpoints.description, email: dpoints.email, phone: dpoints.phone, transport: dpoints.transport, using: MyPersistentContainer.persistentContainer.viewContext)
        MyPersistentContainer.saveContext()
    }
    
    func getDetailFromCoreData() {
        if let managedObject = DetailObject(id: idP).detail[0] as? Details {
            let item = DetailViewModel(id: managedObject.idDetail, title: managedObject.titleDetail, address: managedObject.address, transport: managedObject.transport, email: managedObject.email, geocoordinates: managedObject.geocoordinatesDetail, description: managedObject.descriptionPlace, phone: managedObject.phone)
            self.pointDetail = item
        }
        //print(DetailObject(id: idP).detail[0])
    }
}

struct DetailObject<Details: NSManagedObject>: View {
    
    var fetchRequest: FetchRequest<Details>
    var detail: FetchedResults<Details> { fetchRequest.wrappedValue }
    
    init(id: String) {
        fetchRequest = FetchRequest(entity: Details.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idDetail == %@", id))
    }
    
    var body: some View {
        HStack{
            
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        DetailPlace(idP: .constant("1"))
            .previewLayout(.sizeThatFits)
    }
}



