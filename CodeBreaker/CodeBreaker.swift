//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Barbara Lyakisheva on 1/24/26.
//

import SwiftUI

//typealias - simplifies referring to colors as "Peg" throughout the code
typealias Peg = Color

//Main game logic and state management for the code-breaker game
struct CodeBreaker{

    //secret code the player must guess
    var masterCode: Code = Code(kind: .master)

    //the current code that player is building
    var guess: Code = Code(kind: .guess)

    //history of all previous attempts
    var attempts:[Code] = []

    //available colors the player can choose from
    let pegChoices: [Peg]

    //initializing the game with the optional custom colors (default: red, green, blue, yellow)
    init(pegChoices: [Peg] = [.red, .green, .blue, .yellow]){
        self.pegChoices = pegChoices

        //Generating a random master code using colors from pegChoices
        masterCode.randomize(from: pegChoices)

        //printing master code for debugging
        print(masterCode)
    }

    //validating the current guess and storing it as an attempt with match feedback
    mutating func attemptGuess(){
        var attempt = guess
        
        //comparing the current guess against the master code and generating match results
        attempt.kind = .attempt(guess.match(against: masterCode))

        //adding the completed attempt to the history
        attempts.append(attempt)
    }

    //cycles through available peg colors when the player taps a peg in their guess
    mutating func changeGuessPeg(at index: Int){
        let existingPeg = guess.pegs[index]

        //finding the current peg's position in the available choices
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg){

            //moving to the next color in the list, wrapping around to the start with modulo (%)
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else{

            //if the currrent peg is not found in choices, setting it to the first available color
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
}

//Representing a single code (master code, current guess, previous attempt)
struct Code{

    //type of code (master, guess, attempt)
    var kind: Kind

    //array of 4 colored pegs
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4)

    //represents and empty/unselected peg slot
    static let missing: Peg = .clear

    //enum describing the different types of codes and their associated data
    enum Kind: Equatable{

        //the secret code to be guessed
        case master

        //current incomplete guess being built
        case guess

        //a completed guess with the feedback (array of match results)
        case attempt([Match])

        //default or unknown state
        case unknown
    }

    //fills all peg slots with random colors from the available choices
   mutating func randomize(from pegChoices: [Peg]){
        for index in pegChoices.indices{
            pegs[index]=pegChoices.randomElement() ?? Code.missing
        }
    }

    //returns the match feedback for this code (only if it's an attempt, otherwise empty)
    var matches: [Match]{
        switch kind{

        //return the feedback for completed guesses
        case .attempt(let matches): return matches

        //return empty array for non-attempt codes
        default: return []
        }
    }

    // Comparing this code against another code and returns match feedback
    // This is the core logic that provides hints to the player
    func match(against otherCode: Code) -> [Match]{
        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)

        // Working copy of the master code to track matches
        var pegsToMatch = otherCode.pegs

        // First pass: Check for EXACT matches (correct color in correct position)
        // Process in reverse order to safely remove items while iterating
        for index in pegs.indices.reversed(){
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index]{
                results[index] = .exact

                //Removing this peg from the remaining pegs so it's not matched twice
                pegsToMatch.remove(at: index)
            }
        }

        // Second pass: Check for INEXACT matches (correct color in wrong position)
        for index in pegs.indices{

            // Only check pegs that weren't already marked as exact matches
            if results[index] != .exact{

                // Look for this peg's color elsewhere in the master code
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]){
                    results[index] = .inexact
                    // Remove this peg from remaining pegs so it's not matched twice
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        return results
    }
}
