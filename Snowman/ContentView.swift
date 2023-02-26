//
//  ContentView.swift
//  Snowman
//
//  Created by Jackson Evarts on 2/26/23.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State var ans = "frost"
    
    var body: some View {
        ZStack{
            Image("Scene").resizable().ignoresSafeArea().blur(radius: 3.0)
            VStack{
                Spacer()
                VStack{ //for snowman
                    Image("Tophat").resizable().scaledToFit().aspectRatio(0.70, contentMode: .fit)
                    Image("Snowball").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit)
                    HStack{
                        Image("Stick").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit).rotationEffect(Angle(degrees: 200), anchor: .center)
                        Image("Snowball").resizable().scaledToFit().aspectRatio(0.90, contentMode: .fit)
                        Image("Stick").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit).rotationEffect(Angle(degrees:350), anchor: .center)
                    }
                    Image("Snowball").resizable().scaledToFit().aspectRatio(0.70, contentMode: .fit)
                }
                Spacer()
                HStack{ //For ans
                    Text("_ _ _ _ _")
                }
                Spacer()
                VStack{
                    HStack{
                        Button("Q"){
                            print(" ")
                        }
                        Button("W"){
                            print(" ")
                        }
                        Button("E"){
                            print(" ")
                        }
                        Button("R"){
                            print(" ")
                        }
                        Button("T"){
                            print(" ")
                        }
                        Button("Y"){
                            print(" ")
                        }
                        Button("U"){
                            print(" ")
                        }
                        Button("I"){
                            print(" ")
                        }
                        Button("O"){
                            print(" ")
                        }
                        Button("P"){
                            print(" ")
                        }
                    }
                    HStack{
                        Button("A"){
                            print(" ")
                        }
                        Button("S"){
                            print(" ")
                        }
                        Button("D"){
                            print(" ")
                        }
                        Button("F"){
                            print(" ")
                        }
                        Button("G"){
                            print(" ")
                        }
                        Button("H"){
                            print(" ")
                        }
                        Button("J"){
                            print(" ")
                        }
                        Button("K"){
                            print(" ")
                        }
                        Button("L"){
                            print(" ")
                        }
                        
                    }
                    HStack{
                        Button("Z"){
                            print(" ")
                        }
                        Button("X"){
                            print(" ")
                        }
                        Button("C"){
                            print(" ")
                        }
                        Button("V"){
                            print(" ")
                        }
                        Button("B"){
                            print(" ")
                        }
                        Button("N"){
                            print(" ")
                        }
                        Button("M"){
                            print(" ")
                        }
                    }
                }
                
            }
        }
    }
    func guess(_ g:String) {
        //for i in 1...ans.count{
            //remove button
            //if ans.subscript(i) == g{
                //    Update shown ans
            //}
            
            //else
            //    update snowman
            
        //}
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
