//
//  ContentView.swift
//  Bullseye
//
//  Created by Mateusz Sochanowski on 28/06/2020.
//  Copyright © 2020 Mateusz Sochanowski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisable : Bool = false
    @State var sliderValue : Double = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var roundNumber = 1
    
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier{
        func body(content: Content) -> some View {
            content
                .foregroundColor(.white)
                .font(Font.custom("AmericanTypewriter-Bold", size: 18))
                .modifier(Shadow())
        }
    }
    
    struct ValueStyle: ViewModifier{
        func body(content: Content) -> some View {
            content
                .foregroundColor(.yellow)
                .font(Font.custom("AmericanTypewriter-Bold", size: 24))
                .modifier(Shadow())
        }
    }
    
    struct Shadow: ViewModifier{
        func body(content: Content) -> some View {
            content
                .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier{
           func body(content: Content) -> some View {
               content
                .foregroundColor(.black)
                .font(Font.custom("AmericanTypewriter-Bold", size: 18))
           }
       }
    
    struct ButtonSmallTextStyle: ViewModifier{
             func body(content: Content) -> some View {
                 content
                    .foregroundColor(.black)
                    .font(Font.custom("AmericanTypewriter-Bold", size: 12))
             }
         }
    
        var body: some View {
                VStack {
                    Spacer()
                    //first row
                    HStack {
                        Text("Set bullseye as close as you can to:").modifier(LabelStyle())
                        Text("\(target)").modifier(ValueStyle())
                    }
                    
                    Spacer()
                    //second row
                    HStack {
                        Text("0").modifier(LabelStyle())
                        Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                        Text("100").modifier(LabelStyle())
                    }
                
                    Spacer()
                    //thrid row
                    HStack{
                        Button(action: {
                            print("Button pressed!")
                            self.alertIsVisable = true
                        }) {
                            Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
                        }
                        .alert(isPresented: $alertIsVisable) { () -> Alert in
                                               return Alert(title: Text("\(alertTitle())"), message: Text(
                                                   "The slider value is \(sliderValueRounded()). \n" +
                                                   "You've scored \(calculatePointsFromRound())"), dismissButton: .default(Text("Good!")){
                                                       self.score+=self.calculatePointsFromRound()
                                                       self.target = Int.random(in: 1...100)
                                                       self.roundNumber+=1
                                                   })
                        }
                    }
                    .background(Image("Button")).modifier(Shadow())
                    
                    Spacer()
                    //fourth row
                    HStack{
                        Button(action:{
                            self.startOver()
                        }){
                            HStack{
                                Image("StartOverIcon")
                                Text("Start over").modifier(ButtonSmallTextStyle())
                            }
                        }
                        .background(Image("Button")).modifier(Shadow())
                        
                        Spacer()
                        Text("Score:").modifier(LabelStyle())
                        Text("\(score)").modifier(ValueStyle())
                        Spacer()
                        Text("Round:").modifier(LabelStyle())
                        Text("\(roundNumber)").modifier(ValueStyle())
                        Spacer()
                       NavigationLink(destination: AboutView()){
                            HStack{
                                Image("InfoIcon")
                                Text("Info").modifier(ButtonSmallTextStyle())
                            }
                        }
                        .background(Image("Button")).modifier(Shadow())
                    }
                    .padding(.bottom, 20)
            }
            .background(Image("Background"), alignment: .center)
            .accentColor(midnightBlue)
            .navigationBarTitle("Bullseye")
    }
    
    func sliderValueRounded() -> Int{
        return  Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int{
        return abs(sliderValueRounded() - target)
    }
    
    func calculatePointsFromRound() -> Int{
        let maximumPoints = 100
        let difference = amountOff()
        let bonus: Int
        if difference == 0{
            bonus = 100
        }else if difference == 1{
            bonus = 50
        }else{
            bonus = 0
        }
        return maximumPoints - difference + bonus
    }
    
    func alertTitle() -> String{
        let difference = amountOff()
        let title: String
        if difference < 5{
             title = "Perfect!"
        }
        else if difference <= 10{
            title = "You almost made it!"
        }
        else{
            title = "Are you even trying?"
        }
        return title
    }
    
    func startOver(){
        score = 0
        roundNumber = 1
        self.target = Int.random(in: 1...100)
        self.sliderValue = 50.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
