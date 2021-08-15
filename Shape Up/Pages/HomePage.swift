//
//  HomePage.swift
//  HomePage
//
//  Created by Luke Drushell on 8/14/21.
//

import SwiftUI

struct HomePage: View {
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Text("Shape Up")
                        .padding(.top, 100)
                }
            } .padding()
        } .edgesIgnoringSafeArea(.all)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
        
    }
}
