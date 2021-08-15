//
//  ContentView.swift
//  Shape Up
//
//  Created by Luke Drushell on 8/14/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var showWelcome = false
    
    var body: some View {
        ZStack {
            TabView {
               HomePage()
                    .tabItem{Label("Home", systemImage: "house")}
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                if isFirstTimeOpening() {
                    showWelcome.toggle()
                }
            })
            .sheet(isPresented: $showWelcome, content: {
                ZStack {
                    Text("Welcome to Shape Up!")
                        .font(.title)
                        .bold()
                }
            })
        } .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func isFirstTimeOpening() -> Bool {
  let defaults = UserDefaults.standard

  if(defaults.integer(forKey: "hasRun") == 0) {
      defaults.set(1, forKey: "hasRun")
      return true
  }
  return false

}
