////
////  PointView.swift
////  Touristics Points Swift
////
////  Created by Marta García on 13/9/21.
////


import SwiftUI
import CoreData

struct PointView: View {
    
    @State var pointsArray = [PointViewModel]()
    
    //SearchBar
    @State private var searchText = ""
    @State var searching = false
    @State private var idP = ""
    
    @FetchRequest(
        entity: Point.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Point.title , ascending: true)
        ]
    )var point: FetchedResults<Point>
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
    var body: some View {
        VStack(alignment: .leading){
            SearchBar(searchText: $searchText, searching: $searching)
            Text("POINT")
                .font(.system(size: 40, weight: .black, design: .rounded))
                .padding(.leading)
            
            List(pointsArray.filter({(p: PointViewModel) -> Bool in
                return p.title.hasPrefix(searchText) || searchText.isEmpty
            }), id: \.id) { point in
                PlaceRow(point: point, idP: point.id)
            }
            
            .toolbar {
                if searching {
                    Button("Cancel") {
                        searchText = ""
                        withAnimation {
                            searching = false
                            UIApplication.shared.dismissKeyboard()
                        }
                    }
                }
            }
            .onAppear(perform: getPoint)
        }
    }
    
    func getPoint() {
        let urlPOI = URL(string: "http://t21services.herokuapp.com/points")!
        var request = URLRequest(url: urlPOI)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlPOI) { data, response, error in
            if let data = data {
                if let points = try? JSONDecoder().decode(PointsViewModel.self, from: data) {
                    self.pointsArray = points.list
                    if let appDelegate = self.delegate {
                        appDelegate.clearDataPoint()
                        DispatchQueue.main.async {
                            for i in self.pointsArray {
                                Point.createWith(id: i.id, title: i.title, geocoordinates: i.geocoordinates, using: MyPersistentContainer.persistentContainer.viewContext)
                                MyPersistentContainer.saveContext()
                            }
                        }
                    }
                } else {
                    print("Invalid Response")
                    self.getPointFromCoreData()
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
    
    func getPointFromCoreData() {
        point.forEach { p in
            let item = PointViewModel(id: p.id, title: p.title, geocoordinates: p.geocoordinates)
            //add item to intial array
            self.pointsArray.append(item)
        }
    }
}

struct PlaceRow: View {
    
    let point: PointViewModel
    @State var idP: String
    
    var body: some View {
        NavigationLink(
            destination: DetailView(idP: $idP)) {
                VStack(alignment: .leading) {
                    Text(point.title)
                        .foregroundColor(Color.black)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .padding(.trailing, -200.0)
                        .frame(height: /*@START_MENU_TOKEN@*/50.0/*@END_MENU_TOKEN@*/)
                }
                Spacer()
            }
    }
}

struct PointView_Previews: PreviewProvider {
    static var previews: some View {
        let point = PointViewModel.self
        
        PointView()
        
        PlaceRow(point: point.init(id: "1", title: "Casa Batlló", geocoordinates: "41.391926,2.165208"), idP: "1")
            .previewLayout(.sizeThatFits)
    }
}



