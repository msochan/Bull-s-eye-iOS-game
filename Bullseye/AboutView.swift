//
//  AboutView.swift
//  Bullseye
//
//  Created by Mateusz Sochanowski on 04/07/2020.
//  Copyright © 2020 Mateusz Sochanowski. All rights reserved.
//

import SwiftUI


struct AboutView: View {
    
    let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0) //255, 214, 179
    
    struct HeadingStyle: ViewModifier{
        func body(content: Content) -> some View {
            content
                .font(Font.custom("AmericanTypewriter-Bold", size: 30))
                .foregroundColor(.black)
                .padding(.vertical, 20)
        }
    }

    struct TextViewStyle: ViewModifier{
        func body(content: Content) -> some View {
                content
                    .font(Font.custom("AmericanTypewriter-Bold", size: 16))
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                    .padding(.horizontal,60)
        }
    }
    
    var body: some View {
        Group{
            VStack{
                    Text("🔫Bullseye Game🎯").modifier(HeadingStyle())
                    Text("Welcome to the game. Try to estimate given number to it's closest value.").modifier(TextViewStyle())
                    Text("GOOD LUCK!").modifier(TextViewStyle())
                }
                .background(beige)
                .navigationBarTitle("About Bullseye")
        }
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(   .fixed(width: 896, height: 414))
    }
}
