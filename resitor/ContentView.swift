//
//  ContentView.swift
//  resitor
//
//  Created by Student on 10/22/19.
//  Copyright © 2019 Student. All rights reserved.
//

import SwiftUI

import Foundation
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
func ** (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}


struct ContentView: View {
    public let colors = ["Black", "Brown", "Red", "Orange", "Yellow","Green", "Blue", "Violet","Grey","White"]
    public let uiColors = [Color.black,Color.red, Color.red,                           Color.orange, Color.yellow,Color.green,                       Color.blue, Color.purple,Color.gray,Color.gray]
    @State private var bands = [0,0,0,0,0,0,0,0,0,0,0]				
    @State private var numBands = 3
    var body: some View {
        ZStack {
            Color.init(red: 200/255, green: 224/255, blue: 232/255)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
               
                Text(ohmsCalc( band1:bands[0] ,band2: bands[1] ,multi:bands[2])).padding(.top,100)
                Button(action: {
                                   self.numBands+=1
                               }){Text("+")}.padding(.top,100)
                               HStack {
                                   Text("Number of bands")
                                   Text("\(self.numBands)")
                               }
                               Button(action: {
                                   self.numBands-=1
                               }){Text("-")}
                GeometryReader { geometry in
                    HStack
                        {
                        ForEach((0...self.numBands), id: \.self) {x in
                                Picker(selection: self.$bands[x], label: Text("")) {
                                    ForEach(0 ..< self.colors.count) {
                                        Text(self.colors[$0]).foregroundColor(self.uiColors[$0])
                                    }
                                }
                                .fixedSize(horizontal: true, vertical: true)
                                .frame(width: geometry.size.width / CGFloat(self.numBands), height: geometry.size.height, alignment: .center)
                                .clipped()
                                
                            }
                    }
                    
                    Spacer()
                }
                
            }
        }
    }
    
}

func ohmsCalc( band1:Int,band2:Int ,multi:Int)->String{
    var value = (((band1*10)+band2)*(10**(multi)))
    if value >= 1000000{
        value = value/1000000
        return "\(value) M Ω"
    }
    else if value > 1000{
        value = value/1000
        return "\(value) K Ω"
    }
    else{
        return "\(value) Ω"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


