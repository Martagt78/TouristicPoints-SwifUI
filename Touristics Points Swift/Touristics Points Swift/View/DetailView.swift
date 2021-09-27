////
////  DetailView.swift
////  Touristics Points Swift
////
////  Created by Marta García on 13/9/21.
////

import SwiftUI

struct DetailView: View {
    
    //@State private var showMap = false
    
    @Binding var idP: String
    
    var body: some View {
        
        DetailPlace(id: $idP)
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
                        MapView()
                            .frame(height: 300)
                    }
                    
                    Text(detail.address)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    HStack{
                        Image(systemName: "envelope.fill")
                            .resizable(capInsets: EdgeInsets(top: 2.0, leading: 2.0, bottom: 2.0, trailing: 2.0))
                            .foregroundColor(Color.blue)
                            .frame(width:20.0, height: 20.0)
                        Text(detail.email)                            .font(.title2)
                            .multilineTextAlignment(.leading)
                    }
                    
                    HStack{
                        Image(systemName: "phone.fill")
                            .resizable()
                            .foregroundColor(Color.blue)
                            .frame(width: 20, height: 20)
                        Text(detail.phone)
                            .font(.title2)
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
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        DetailPlace(id: .constant("1"))
            .previewLayout(.sizeThatFits)
    }
}



