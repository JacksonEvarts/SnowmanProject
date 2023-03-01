//
//  ContentView.swift
//  Snowman
//
//  Created by Eli Werstler, Jackson Evarts, Thomas Creighton on 2/26/23.
//  hangman but with snow.

import SwiftUI


struct ContentView: View {
    var ans = "frosty"
    let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ'")
    @State var uncAnsPos: [Int] = [] // Array holding positions of correctly guessed letters
    @State var uncAns: String // Initialized as string of "_" but will slowly become the correct word
    init() {
        var str = ""
        for _ in 0..<ans.count {
            str += "_ "
        }
        self.uncAns = str
    } // Postcondition: Initializes uncAns into a string with as many _ as there are letters in the final answer
    
    var body: some View {
        ZStack{
            Image("Scene").resizable().ignoresSafeArea().blur(radius: 3.0)
            VStack{
                Spacer()
                snowman()
                Spacer()
                HStack{ //For ans
                    Text(uncAns)
                }
                Spacer()
                VStack {
                    ForEach(0..<3) { row in
                        HStack {
                            ForEach(0..<9) { column in
                                let index = row * 9 + column
                                if index < letters.count {
                                    Button(String(letters[index])) {
                                            uncAnsPos += guess(letter: letters[index], word: ans) // Calling
                                            uncAns = ansLine(uncAnsPositions: uncAnsPos, uncAnswers: uncAns, answer: ans)
                                            $0.isEnabled = false // Disable the button when it is pressed
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
}
private func snowman() -> some View {
    VStack{ // For snowman
        Image("Tophat").resizable().scaledToFit().aspectRatio(0.70, contentMode: .fit)
        Image("Snowball").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit)
        HStack{
            Image("Stick").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit).rotationEffect(Angle(degrees: 200), anchor: .center)
            Image("Snowball").resizable().scaledToFit().aspectRatio(0.90, contentMode: .fit)
            Image("Stick").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit).rotationEffect(Angle(degrees:350), anchor: .center)
        }
        Image("Snowball").resizable().scaledToFit().aspectRatio(0.70, contentMode: .fit)
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
    
    return positions
} // Postcondition: Function returns an array of each position that the letter shows up in the answer.

// Function takes array of positions of guessed values within answer, a string showing blank spaces and previously uncovered letters, and an answer string.
func ansLine(uncAnsPositions: [Int], uncAnswers: String, answer: String) -> String {
    var result = ""
        var index = 0
        for char in uncAnswers {
            if char == "_" {
                if uncAnsPositions.contains(index) {
                    result.append(answer[answer.index(answer.startIndex, offsetBy: index)])
                } else {
                    result.append(char)
                }
                index += 1
            } else {
                result.append(char)
            }
        }
        return result
}
// Returns updated string of blank spaces (underscores) and uncovered letters in approprate positions.

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
