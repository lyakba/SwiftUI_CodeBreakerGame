//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Barbara Lyakisheva on 1/16/26.
//  updated: 1/24/26

import SwiftUI

//enump represents the three possible match states for each peg in a guess
enum Match{

    //peg color does not exist in the master code
    case nomatch

    //peg color is correct and in the correct position
    case exact

    //peg color exists in the code but it is in the wrong position
    case inexact
}

//View that displays visual feedback showing how close a guess was to the master code
struct MatchMarkers: View{

     //array of match results for each peg in the guess
    var matches: [Match]
    
    var body: some View{

        //creating a 2x2 grid of feedback markers (4 markers for 4 pegs)
        HStack{

            //left column: markers for pegs 0 and 1
            VStack{
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            }

            //right column: markers for pegs 2 and 3
            VStack{
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
        }
    }

    //creating a single feedback marker circle for a given peg position
    func matchMarker(peg: Int) -> some View{

        //counting how many pegs have exact matches(correct color, correct position)
        let exactCount = matches.count { $0 == .exact }

        //counting how many pegs have any match (exact or inexact - any color that was found)
        let foundCount = matches.count { $0 != .nomatch }

        //returning the circle
        return Circle()

            //filled circle: displayed if this peg position has any match found
            .fill(exactCount > peg ? Color.primary : Color.clear)

            //outlined/hollow circle: displayed if this peg position has any match found
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)

            //keeping the marker square
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview{
    //Example: Shows 1 exact match, 1 inexact and 1 no match
    MatchMarkers(matches:[.exact, .inexact, .nomatch])
}
