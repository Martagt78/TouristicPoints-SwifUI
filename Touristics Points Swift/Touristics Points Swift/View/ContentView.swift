//
//  ContentView.swift
//  Touristics Points Swift
//
//  Created by Marta García on 10/9/21.
//

import SwiftUI

struct ContentView: View {
    
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
                        .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .frame(width: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                    
                    Spacer()
                    
                    HStack{
                        Spacer()
                        NavigationLink(
                            destination: PointView()) {
                                
                                Label(
                                    title: { Text("Show Points")
                                            .background(Color("LightGray"))
                                            .foregroundColor(.black)
                                            .font(.title2)
                                    },
                                    icon: {
                                        Image(systemName: "map.fill")
                                            .foregroundColor(.black)
                                    }
                                ).multilineTextAlignment(.center)
                                    .padding(.bottom, 19.0)
                                
                            }
                            
                        Spacer()
                    }
                    Spacer()
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
