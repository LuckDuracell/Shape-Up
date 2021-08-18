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
    
    @State var showWelcome = false
    @State var userGoalsArray = Goals.loadFromFile()
    @State var userInfo = User.loadFromFile()
    @State var userGoals = Goals(waterIntake: 3, sleepHours: 3, workoutTime: 3)
    
    @State var completedGoals: [DaysGoals] = [DaysGoals(waterIntake: 0, sleepHours: 0, workoutTime: 0, date: Date())]
    @State var settingWorkoutTime = "0"
    
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
                        ScrollView {
                            Text("\(completedGoals[0].date.formatted().components(separatedBy: ",").first!)")
                            Stepper("Water: \(shortenDouble(completedGoals[0].waterIntake))/\(shortenDouble(userGoals.waterIntake))", onIncrement: {
                                completedGoals[0].waterIntake += 0.5
                                DaysGoals.saveToFile(completedGoals)
                            }, onDecrement: {
                                completedGoals[0].waterIntake -= 0.5
                                DaysGoals.saveToFile(completedGoals)
                            })
                                .padding()
                                .background(.gray.opacity(0.2))
                                .cornerRadius(15)
                                .padding()
                            Stepper("Sleep: \(shortenDouble(completedGoals[0].sleepHours))/\(shortenDouble(userGoals.sleepHours))", onIncrement: {
                                completedGoals[0].sleepHours += 0.5
                                DaysGoals.saveToFile(completedGoals)
                            }, onDecrement: {
                                completedGoals[0].sleepHours -= 0.5
                                DaysGoals.saveToFile(completedGoals)
                            })
                                .padding()
                                .background(.gray.opacity(0.2))
                                .cornerRadius(15)
                                .padding()
                            TextField("Exercise Minutes", text: $settingWorkoutTime, prompt: Text("Exercise Minutes"))
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(.gray.opacity(0.2))
                                .cornerRadius(15)
                                .padding()
                                .onAppear(perform: {
                                    settingWorkoutTime = "\(shortenDouble(completedGoals[0].workoutTime))"
                                })
                                .onSubmit {
                                    completedGoals[0].workoutTime =  Double(settingWorkoutTime) ?? 0
                                    DaysGoals.saveToFile(completedGoals)
                                    print("saved")
                                }
                        }
                        .toolbar(content: {
                            ToolbarItemGroup(placement: .keyboard, content: {
                                HStack {
                                    Spacer()
                                    Button("Done") {
                                        hideKeyboard()
                                    }
                                }
                            })
                        })
                        Spacer()
                    }, label: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("🧊  \(shortenDouble(completedGoals[0].waterIntake))/\(shortenDouble(userGoals.waterIntake)) Cups of Water")
                                .foregroundColor(Color("MainBlue"))
                                .padding(5)
                            Text("🏋️  \(shortenDouble(completedGoals[0].workoutTime))/\(shortenDouble(userGoals.workoutTime)) minutes of Exercise")
                                .foregroundColor(Color("MainBlue"))
                                .padding(5)
                            Text("🛏  \(shortenDouble(completedGoals[0].sleepHours))/\(shortenDouble(userGoals.sleepHours)) Hours of Sleep")
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
                } .padding(.horizontal)
            } .navigationTitle("Home")
        } .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                if isFirstTimeOpening() {
                    showWelcome.toggle()
                }
                if userGoalsArray.isEmpty == false {
                    userGoals = userGoalsArray[0]
                }
                if DaysGoals.loadFromFile().isEmpty == false {
                    completedGoals = DaysGoals.loadFromFile()
                } else {
                    DaysGoals.saveToFile([DaysGoals(waterIntake: 0, sleepHours: 0, workoutTime: 0, date: Date())])
                    completedGoals = DaysGoals.loadFromFile()
                }
            })
            .sheet(isPresented: $showWelcome, onDismiss: {
                userGoalsArray = Goals.loadFromFile()
                userGoals = userGoalsArray[0]
            }, content: {
                WelcomeSheet(showWelcome: $showWelcome)
            })
    }
}

//struct HomePage_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePage()
//    }
//}

func shortenDouble(_ temp: Double) -> String {
    var tempVar = String(format: "%g", temp)
    return tempVar
}
