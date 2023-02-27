//
//  ContentView.swift
//  Snowman
//
//  Created by Eli Werstler, Jackson Evarts, Thomas Creighton on 2/26/23.
//

import SwiftUI


struct ContentView: View {
    @State var ans = "frost"
    let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ'")
    
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
                VStack {
                    ForEach(0..<3) { row in
                        HStack {
                            ForEach(0..<9) { column in
                                let index = row * 9 + column
                                if index < letters.count {
                                    Button(String(letters[index])) {
                                        guess(letter: letters[index], word: ans)
                                    }
                                } else {
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
}
// Precondition: Function is passed a valid letter and word.
func guess(letter: Character, word: String) -> [Int] {
    var positions: [Int] = [] // Array to store each of the positions of the character
    for (index, lookAt) in word.enumerated() {
        if lookAt == letter { // Comparing the current letter of the answer with the guessed letter
            positions.append(index) // If the guessed letter appears in the answer add the current index to the array
        }
    }
    // TODO: Turn off the button of the guessed letter
    
    return positions
} // Postcondition: Function returns and array of each position that the letter shows up in the answer. The button to click the letter is also turned off so it cannot be guesed again.


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
  