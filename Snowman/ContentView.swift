//
//  ContentView.swift
//  Snowman
//
//  Created by Eli Werstler, Jackson Evarts, Thomas Creighton on 2/26/23.
//  hangman but with snow.

import SwiftUI


struct ContentView: View {
    var ans = "fruusty"
    let letters = Array("abcdefghijklmnopqrstuvwxyz'") // lowercase alphabet
    @State var numWrong = 0
    @State var uncAnsPos: [Int] = [] // Array holding positions of correctly guessed letters
    @State var uncAns: String // Initialized as string of "_" but will slowly become the correct word
    //@State var guessed: [String] = [] // Array holding characters that have been guessed (right or wrong)
    // TODO: Make this scroller work ^
    init() {
        var str = ""
        for _ in 0..<ans.count {
            str += "_ "
        }
        self.uncAns = str
    } // Postcondition: Initializes uncAns into a string with as many _ as there are letters in the final answer
    
    var body: some View {
        ZStack{
            // TODO: Import the scene image so there is a background to the snowman
            Image("Scene").resizable().ignoresSafeArea().blur(radius: 3.0)
            
            VStack{
                /*
                 // TODO: Make this scroller work v
                ScrollView(.horizontal) {
                    HStack(spacing: 10){
                        Text("Guessed letters so far: ")
                        for item in guessed{
                            Text(item + " ")
                                .frame(width: 10, height: 10)
                                .bold()
                        }
                    }
                }//.scaledToFit()
                */
                 
                Text("This is Bob.")
                Spacer()
                 VStack{ // For snowman
                    if numWrong > 5{
                        Image("Tophat").resizable().scaledToFit().aspectRatio(0.70, contentMode: .fit)
                    } else {
                        Spacer()   
                    }
                    if numWrong > 4{
                        Image("Snowball").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit)
                    } else {
                        Spacer()   
                    }
                    HStack{
                        if numWrong > 2{
                            Image("Stick").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit).rotationEffect(Angle(degrees: 200), anchor: .center)
                        } else {
                            Spacer()   
                        }
                        if numWrong > 1{
                            Image("Snowball").resizable().scaledToFit().aspectRatio(0.90, contentMode: .fit)
                        } else {
                            Spacer()   
                        }
                        if numWrong > 3{
                            Image("Stick").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit).rotationEffect(Angle(degrees:350), anchor: .center)
                        } else {
                            Spacer()   
                        }        
                    }
                    if numWrong > 0 {
                        Image("Snowball").resizable().scaledToFit().aspectRatio(0.70, contentMode: .fit)
                    } else {
                        Spacer()   
                    }
                }
                Spacer()
                HStack{
                    Text(uncAns)
                }
                Spacer()
                VStack { // Keyboard VStack
                    ForEach(0..<3) { row in
                        HStack {
                            ForEach(0..<9) { column in
                                let index = row * 9 + column
                                var positions: [Int] = []
                                if index < letters.count {
                                    Button(String(letters[index])) {
                                        // guessed.append(String(letters[index])) // Adding guessed letter to the array desplayed
                                        // TODO: Make side scroller work ^
                                        positions = guess(letter: letters[index], word: ans)
                                        uncAnsPos +=  positions // Calling
                                        if positions.isEmpty{
                                            numWrong = numWrong + 1
                                        }
                                        uncAns = ansLine(uncAnsPositions: uncAnsPos, uncAnswers: uncAns, answer: ans)
                                        //$0.isEnabled = false // Disable the button when it is pressed
                                        // TODO: Make this button disablement work ^
                                    }
                                }
                            }
                        }
                    }
                } // End of keyboard VStack
                
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
    return positions
} // Postcondition: Function returns an array of each position that the letter shows up in the answer.

// Precondition: Function takes array of positions of guessed values within answer, a string showing blank spaces and previously uncovered letters, and an answer string.
func ansLine(uncAnsPositions: [Int], uncAnswers: String, answer: String) -> String {
    var result = ""
        var index = 0
        for char in uncAnswers {
            if char != " " {
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
} // Postcondition: Returns updated string of blank spaces (underscores) and uncovered letters in approprate positions.

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
