////
////  DetailView.swift
////  Touristics Points Swift
////
////  Created by Marta García on 13/9/21.
////

import SwiftUI

struct DetailView: View {
    
    @Binding var idP: String
    
    var body: some View {
        
        DetailPlace(id: $idP)
    }
}

struct DetailPlace: View {
    
    @State var pointDetail: DetailViewModel?
    @Binding var idP: String
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
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
    
    init(id: Binding<String>) {
        self._idP = id
    }
    
    func getDetailPoint() {
            
            let urlDetailPOI = URL(string: "http://t21services.herokuapp.com/points/\(idP)")! //Pasar ID que queremos mostrar
            var request = URLRequest(url: urlDetailPOI)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: urlDetailPOI) { data, response, error in
                
                if let data = data {
                    if let points = try? JSONDecoder().decode(DetailViewModel.self, from: data) {
                        self.pointDetail = points
                    } else {
                        print("Invalid Response")
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }
            task.resume()
        }
    
//    func getDetailPoint() {
//        let urlDetailPOI = URL(string: "http://t21services.herokuapp.com/points/\(idP)")! //Pasar ID que queremos mostrar
//        var request = URLRequest(url: urlDetailPOI)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let task = URLSession.shared.dataTask(with: urlDetailPOI) { data, response, error in
//            if let data = data {
//                if let dpoints = try? JSONDecoder().decode(DetailViewModel.self, from: data) {
//                    self.updateContext(detailPoints: dpoints)
//                } else {
//                    print("Invalid Response")
//                    self.refreshDetailDataCore()
//                }
//            } else if let error = error {
//                print("HTTP Request Failed \(error)")
//            }
//
//        }
//        task.resume()
//    }
//
//    func refreshDetailDataCore() {
//        @FetchRequest(
//            entity: Details.entity(),
//            sortDescriptors: [
//                NSSortDescriptor(keyPath: \Details.titleDetail, ascending: true)
//            ],
//            predicate: NSPredicate(format: "idDetails = \(idP)")
//        ) var detail: FetchedResults<Details>
//
//        var detailsArray: [DetailViewModel] = []
//        detail.forEach { i in
//            let item = DetailViewModel(id: i.idDetail, title: i.titleDetail, address: i.address, transport: i.transport, email: i.email, geocoordinates: i.geocoordinatesDetail, description: i.descriptionPlace, phone: i.phone)
//            detailsArray.append(item)
//        }
//    }
//
//    func updateContext(detailPoints: DetailViewModel) {
//        @FetchRequest(
//            entity: Details.entity(),
//            sortDescriptors: [
//                NSSortDescriptor(keyPath: \Details.titleDetail, ascending: true)
//            ],
//            predicate: NSPredicate(format: "idDetails = \(idP)")
//        ) var detail: FetchedResults<Details>
//
//        if detail.count > 0 {
//            let manageObject = detail[0]
//            manageObject.titleDetail = detailPoints.title
//            manageObject.geocoordinatesDetail = detailPoints.geocoordinates
//            manageObject.address = detailPoints.address
//            manageObject.descriptionPlace = detailPoints.description
//            manageObject.email = detailPoints.email
//            manageObject.transport = detailPoints.transport
//            MyPersistentContainer.saveContext()
//
//
//        } else {
//            Details.createWith(id: detailPoints.id, title: detailPoints.title, geocoordinates: detailPoints.geocoordinates, address: detailPoints.address, description: detailPoints.description, email: detailPoints.email, phone: detailPoints.phone, transport: detailPoints.transport, using: MyPersistentContainer.persistentContainer.viewContext)
//        }
//    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        DetailPlace(id: .constant("1"))
            .previewLayout(.sizeThatFits)
    }
}



