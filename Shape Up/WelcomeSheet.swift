//
//  WelcomeSheet.swift
//  WelcomeSheet
//
//  Created by Luke Drushell on 8/15/21.
//

import SwiftUI

struct WelcomeSheet: View {
    
    @Binding var showWelcome: Bool
    @State var tabSelection = 1
    
    @State var userSettings = User(name: "", gender: 0, height: 60, weight: 120, age: 18, birthday: Date())
    @State var gender = "Gender"
    let genderOptions = ["Gender", "Male", "Female", "Non-Binary", "Other", "Prefer Not to Say"]
    @State var weight = ""
    @State var ft = 5
    @State var In = 6
    let ftOptions = [0, 1, 2, 3, 4, 5, 6, 7]
    let InOptions = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    
    @State var userGoals = Goals(waterIntake: 6, sleepHours: 8, workoutTime: 45)
    let waterOptions = [3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10]
    let sleepOptions = [5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10]
    @State var workoutTime: String = ""
    
    var body: some View {
        TabView(selection: $tabSelection) {
                ZStack {
                    VStack {
                        Spacer()
                        Image(systemName: "square.on.circle")
                            .resizable()
                            .foregroundColor(Color("MainBlue"))
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: .center)
                            .padding(.top, 35)
                        Text("Welcome to Shape Up!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("MainBlue"))
                            .padding(.bottom, 30)
                            .padding()
                            .multilineTextAlignment(.center)
                        HStack {
                            Text("💆‍♂️")
                                .font(.largeTitle)
                                .bold()
                            Text("Stay mindful about your health by tracking workouts, water intake, sleep, and more!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading)
                        } .padding(20)
                        HStack {
                            Text("❤️")
                                .font(.largeTitle)
                                .bold()
                            Text("Find the fun in self improvement by completing goals and reciving positive encouragement!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading)
                        } .padding(20)
                        HStack {
                            Text("🕑")
                                .font(.largeTitle)
                                .bold()
                            Text("Tracking your health has never been easier, with a modern design and helpful features such as Siri support!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(width: UIScreen.main.bounds.width*0.7, alignment: .leading)
                        } .padding(20)
                        Spacer()
                        Button {
                            withAnimation {
                                tabSelection = 2
                            }
                        } label: {
                            Text("Next")
                                .bold()
                                .frame(width: 250, height: 50, alignment: .center)
                                .foregroundColor(.primary)
                                .background(Color("MainBlue"))
                                .cornerRadius(25)
                        } .padding(30)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.vertical)
                .tag(1)
            NavigationView {
                ZStack {
                    VStack {
                        Spacer()
                        Text("We Need Some Info to Begin")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color("MainBlue"))
                            .padding(30)
                            .multilineTextAlignment(.center)
                        TextField("Name", text: $userSettings.name)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width*0.9, height: 50, alignment: .center)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(15)
                            .padding()
                            .textInputAutocapitalization(.words)
                            .keyboardType(.alphabet)
                            .textContentType(.name)
                        HStack {
                            Picker("Gender", selection: $gender, content: {
                                ForEach(genderOptions, id: \.self, content: {
                                    Text($0)
                                })
                            })
                                .pickerStyle(.menu)
                                .frame(width: UIScreen.main.bounds.width*0.2, height: 35)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(10)
                                .padding(.leading)
                            DatePicker("Birthday", selection: $userSettings.birthday, displayedComponents: .date)
                                .padding(.leading)
                                .frame(width: UIScreen.main.bounds.width*0.675, height: 35)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(8)
                                .padding(.trailing)
                        }
                        TextField("Weight (lbs)", text: $weight)
                            .keyboardType(.decimalPad)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width*0.9, height: 50, alignment: .center)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(15)
                            .padding()
                        HStack {
                            Spacer()
                            Picker("Ft", selection: $ft, content: {
                                ForEach(ftOptions, id: \.self, content: {
                                    Text("\($0) Ft")
                                })
                            })
                                .frame(width: UIScreen.main.bounds.width*0.45, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipped()
                            Picker("In", selection: $In, content: {
                                ForEach(InOptions, id: \.self, content: {
                                    Text("\($0) In")
                                })
                            })
                                .frame(width: UIScreen.main.bounds.width*0.45, height: 100)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            Spacer()
                        }
                        .pickerStyle(.inline)
                        .padding()
                        Spacer()
                        Button {
                            
                            var genderInt = 0
                            switch gender {
                            case "Gender":
                                genderInt = 5
                            case "Male":
                                genderInt = 0
                            case "Female":
                                genderInt = 1
                            case "Non-Binary":
                                genderInt = 3
                            case "Prefer Not to Say":
                                genderInt = 4
                            default:
                                genderInt = 5
                            }
                            
                            User.saveToFile([User(name: userSettings.name, gender: genderInt, height: Double((ft*12)+In), weight: Double(weight) ?? 140, age: 15, birthday: userSettings.birthday)])
                            
                            withAnimation {
                                tabSelection = 3
                            }
                            
                        } label: {
                            Text("Next")
                                .bold()
                                .frame(width: 250, height: 50, alignment: .center)
                                .foregroundColor(.primary)
                                .background(Color("MainBlue"))
                                .cornerRadius(25)
                        } .padding(30)
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
                } .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.top)
            }
            .edgesIgnoringSafeArea(.all)
                .tag(2)
            NavigationView {
                ZStack {
                    VStack {
                        Spacer()
                        Text("Okay Last Thing, We Promise")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color("MainBlue"))
                            .padding(30)
                            .multilineTextAlignment(.center)
                        TextField("45", text: $workoutTime, prompt: Text("Daily Workout Goal (Minutes)"))
                            .keyboardType(.decimalPad)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width*0.9, height: 50, alignment: .center)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(15)
                            .padding()
                        Text("Cups of Water")
                            .bold()
                            .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                        Picker("Cups of Water", selection: $userGoals.waterIntake, content: {
                            ForEach(waterOptions, id:\.self, content: {
                                let text = "\($0)"
                                if text.prefix(2) != "10" {
                                    Text(text.contains(".5") ? text.prefix(3) : text.prefix(1))
                                } else {
                                    Text("10")
                                }
                            })
                        })
                            .pickerStyle(.wheel)
                            .frame(height: UIScreen.main.bounds.height * 0.13, alignment: .center)
                            .clipped()
                        Text("Hours of Sleep")
                            .bold()
                            .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                        Picker("Hours of Sleep", selection: $userGoals.sleepHours, content: {
                            ForEach(sleepOptions, id:\.self, content: {
                                let text = "\($0)"
                                if text.prefix(2) != "10" {
                                    Text(text.contains(".5") ? text.prefix(3) : text.prefix(1))
                                } else {
                                    Text("10")
                                }
                            })
                        })
                            .pickerStyle(.wheel)
                            .frame(height: UIScreen.main.bounds.height * 0.13, alignment: .center)
                            .clipped()
                        Spacer()
                        Button {
                            userGoals.workoutTime = Double(workoutTime) ?? 30
                            Goals.saveToFile([userGoals])
                            showWelcome.toggle()
                        } label: {
                            Text("Get Started")
                                .bold()
                                .frame(width: 250, height: 50, alignment: .center)
                                .foregroundColor(.primary)
                                .background(Color("MainBlue"))
                                .cornerRadius(25)
                        } .padding(30)
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
                } .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.top)
            }
            .edgesIgnoringSafeArea(.all)
                .tag(3)

        } .tabViewStyle(.page)
        .accentColor(Color("MainBlue"))
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            UIDatePicker.appearance().backgroundColor = .clear
            UIDatePicker.appearance().tintColor = UIColor(Color("MainBlue"))
        })
    }
}

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
