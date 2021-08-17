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
                    .tabItem{Label("Home", systemImage: "house.fill")}
                LogPage()
                    .tabItem{Label("Logs", systemImage: "tray.full.fill")}
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                if isFirstTimeOpening() == false{
                    showWelcome.toggle()
                }
            })
            .sheet(isPresented: $showWelcome, content: {
                WelcomeSheet(showWelcome: $showWelcome)
            })
        } .edgesIgnoringSafeArea(.all)
            .accentColor(Color("MainBlue"))
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
