//
//  HomePage.swift
//  HomePage
//
//  Created by Luke Drushell on 8/14/21.
//

import SwiftUI
import HealthKit
import HealthKitUI

struct HomePage: View {
    
    
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    Text("Daily Goals")
                        .font(.title2)
                        .bold()
                        .frame(width: UIScreen.main.bounds.width*0.9, alignment: .leading)
                        .padding(5)
                    NavigationLink(destination: {
                        
                    }, label: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("🧊  \(3)/\(6) Cups of Water")
                                .foregroundColor(Color("MainBlue"))
                                .padding(5)
                            Text("🏋️  \(35)/\(45) minutes of Exercise")
                                .foregroundColor(Color("MainBlue"))
                                .padding(5)
                            Text("🛏  \(8)/\(8) Hours of Sleep")
                                .foregroundColor(Color("MainBlue"))
                                .padding(5)
                        }
                        .font(.headline)
                        .padding(5)
                        .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.gray.opacity(0.2)))
                        .overlay(alignment: .topTrailing,content: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding()
                        })
                    })
                } .padding()
            } .navigationTitle("Home")
        } .edgesIgnoringSafeArea(.all)
    }
}

//struct HomePage_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePage()
//    }
//}
