//
//  ContentView.swift
//  Touristics Points Swift
//
//  Created by Marta García on 10/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var pointsArray = [PointViewModel]()
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                
                Image("Bcn")
                    .resizable()
                    .aspectRatio(geo.size, contentMode: .fill)
                    .opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("BARCELONA")
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .bottom], 100.0)
    
                    NavigationLink(
                        destination: PointView()) {
                            Label(
                                title: { Text("Points of Interest")
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .padding(.top) },
                                icon: {
                                    Image(systemName: "map.fill")
                                        .foregroundColor(.black)
                                }
                            )
                        }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
