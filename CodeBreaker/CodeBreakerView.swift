//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Barbara Lyakisheva on 1/15/26.
// updated: 1/24/26

import SwiftUI

//Main view for the CodeBreaker game
struct CodeBreakerView: View{

    //initializing the game with a master code that cointains 4 colored pegs that the player must guess
    @State var game = CodeBreaker(pegChoices: [.brown, .yellow, .orange, .black])
    
    var body: some View{
        VStack{

            //displaying the master code (code to be guessed)
            view(for: game.masterCode)

            //scrollable section containing the current guess and all previous attempts
            ScrollView{

                //displaying the current incomplete guess that the player is building
                view(for: game.guess)

                //displaying all previous attempts in reverse order -> newest first
                //Uses reversed() to show most recent guesses at the top
                ForEach(game.attempts.indices.reversed(), id: \.self){
                    index in
                    view(for: game.attempts[index])

                }
            }
        }
        .padding()
    }

    //Button that allows the player to submit their current guess
    var guessButton: some View{
        Button("Guess"){

            //Animating the game state change when a guess is submitted
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 80))

        //Allowing text to shrink if needed to fit
        .minimumScaleFactor(0.1)
    }

    //Generic function that creates a visual representation of a code(master code, current guess, or a past attempt)
    func view(for code: Code) -> some View{
        HStack{

            //looping through each peg position in the code (typically 4 pegs)
            ForEach(code.pegs.indices, id: \.self){
                index in

                //Creating a rounded rectangle for each peg (the colored circles)
                RoundedRectangle(cornerRadius: 10)
                    .overlay{

                        //if the peg is empty (missing) -> gray border outline instead of a filled color
                        if code.pegs[index] == Code.missing{
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray)
                        }
                    }

                    //making the peg tappable
                    .contentShape(Rectangle())

                    //keeping the peg square-shaped
                    .aspectRatio(1, contentMode: .fit)

                    //coloring the peg based on its value
                    .foregroundStyle(code.pegs[index])
                    .onTapGesture {

                        //allowing players to change peg colors only for the current guess, not past attempts
                        if code.kind == .guess{
                            game.changeGuessPeg(at: index)
                        }
                    }
            }

            //Displaying match markers (showing how many pegs are correct color/position)
            MatchMarkers(matches: code.matches)
                .overlay{

                    //Showing the guess button only on the current guess row, not on past attempts
                    if code.kind == .guess{
                        guessButton
                    }
                }
        }
    }
}

#Preview {
    CodeBreakerView()
}
