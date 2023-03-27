//
//  ContentView.swift
//  Snowman
//
//  Created by Eli Werstler, Jackson Evarts, Thomas Creighton on 2/26/23.
//  hangman but with snow.

import SwiftUI


struct ContentView: View {
    @State var ans: String 
    let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ'")
    @State var win = false
    @State var loss = false
    @State var numWrong = 0
    @State var uncAnsPos: [Int] = [] // Array holding positions of correctly guessed letters
    @State var uncAns: String // Initialized as string of "_" but will slowly become the correct word
    @State var buttonDisabledStates: [Bool] = Array(repeating: false, count: 27) // Initializes array of disabled states for each button
    init() {
        var str1 = ""
        if let path = Bundle.main.path(forResource: "dictionary", ofType: "txt"){
            do{
                let contents = try String(contentsOfFile: path, encoding: .utf8)
                let lines = contents.split(separator:"\n")
                str1 = String(lines.randomElement() ?? "")
            } catch {
                
            }
        }
        var str = ""
        for _ in 0..<str1.count {
            str += "_ "
        }
        self.uncAns = str
        self.ans = str1.uppercased()
    } // Postcondition: Initializes uncAns into a string with as many _ as there are letters in the final answer
    var body: some View {
        ZStack{
            Image("Scene").resizable().ignoresSafeArea().blur(radius: 3.0)
            VStack{
                Spacer()
                VStack{ // For snowman
                    if loss == true {
                        Button("You Lost! - Click to Restart") {
                            loss = false
                            numWrong = 0
                            uncAnsPos = []
                            buttonDisabledStates = Array(repeating: false, count: 27)
                            newWord()
                        }
                    } else if win == true {
                        Button("You Win! - Click to Restart") {
                            win = false
                            numWrong = 0
                            buttonDisabledStates = Array(repeating: false, count: 27)
                            newWord()
                        }
                    } else {
                        Button("Click to Restart") {
                            numWrong = 0
                            buttonDisabledStates = Array(repeating: false, count: 27)
                            newWord()
                        }
                    }
                    Image("Tophat").resizable().scaledToFit().aspectRatio(0.70, contentMode: .fit).opacity(numWrong > 5 ? 1.0 : 0.0)
                    Image("Snowball").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit).opacity(numWrong > 4 ? 1.0 : 0.0)
                    HStack{
                        Image("Stick").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit).rotationEffect(Angle(degrees: 200), anchor: .center).opacity(numWrong > 2 ? 1.0 : 0.0)
                        Image("Snowball").resizable().scaledToFit().aspectRatio(0.90, contentMode: .fit).opacity(numWrong > 1 ? 1.0 : 0.0)
                        Image("Stick").resizable().scaledToFit().aspectRatio(0.50, contentMode: .fit).rotationEffect(Angle(degrees:350), anchor: .center).opacity(numWrong > 3 ? 1.0 : 0.0)
                    }
                    Image("Snowball").resizable().scaledToFit().aspectRatio(0.70, contentMode: .fit).opacity(numWrong > 0 ? 1.0 : 0.0)
                }
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
                                var positions: [Int] = []
                                if index < letters.count {
                                    Button(String(letters[index])) {
                                        positions = guess(letter: letters[index], word: ans)
                                        uncAnsPos +=  positions // Calling
                                        if positions.isEmpty{
                                            numWrong = numWrong + 1
                                            if numWrong > 5 {
                                                loss = true
                                                buttonDisabledStates = Array(repeating: true, count: 27)
                                            }
                                        }
                                        uncAns = ansLine(uncAnsPositions: uncAnsPos, uncAnswers: uncAns, answer: ans)
                                        win = checkWin(uncAns: uncAns)
                                        if win {
                                            buttonDisabledStates = Array(repeating: true, count: 27)
                                        }
                                        buttonDisabledStates[index] = true // Disable the button when it is pressed
                                    }
                                    .disabled(buttonDisabledStates[index])
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func newWord() { // Precondition: dictionary.txt is a file within Assets
        var str1 = ""
        if let path = Bundle.main.path(forResource: "dictionary", ofType: "txt"){
            do{
                let contents = try String(contentsOfFile: path, encoding: .utf8)
                let lines = contents.split(separator:"\n")
                str1 = String(lines.randomElement() ?? "")
            } catch {
                
            }
        }
        ans = str1.uppercased()
        var str = ""
        for _ in 0..<str1.count {
            str += "_ "
        }
        uncAns = str
    }  // Postcondition: returns a new word from the dictionary
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
}
// Returns updated string of blank spaces (underscores) and uncovered letters in approprate positions.

// Function takes the current answer line
func checkWin(uncAns: String) -> Bool {
    for char in uncAns {
        if char == "_" {
            return false
        }
    }
    return true
} // Postcondition: Returns false if there are still letters to guess (there are underscores), true if there are none left and the user wins




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
