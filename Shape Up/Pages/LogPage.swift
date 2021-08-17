//
//  LogPage.swift
//  LogPage
//
//  Created by Luke Drushell on 8/15/21.
//

import SwiftUI

struct LogPage: View {
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        
                    }
                } .padding()
            } .navigationTitle("Logs")
        } .edgesIgnoringSafeArea(.all)
    }
}

struct LogPage_Previews: PreviewProvider {
    static var previews: some View {
        LogPage()
    }
}
