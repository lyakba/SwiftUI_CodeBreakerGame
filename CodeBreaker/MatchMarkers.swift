//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Barbara Lyakisheva on 1/16/26.
//  updated: 1/16/26

import SwiftUI

//defining an enum that represents the three possible feedback states
enum Match{
    case nomatch //peg color does not appear in the final code
    case exact //peg color does appear in the code and the location is correct
    case inexact //peg color does appear in the code, but location is incorrect
}

//MatchMarkers - display visual feedback circles
//The layout and number of circles adapt based on the size of the matches array
struct MatchMarkers: View{
    
    //array of match values that represent feedback for each peg
    var matches: [Match]
    var body: some View{
        
        //using switch statement to determine the layout based on the number of matches
        switch self.matches.count{
            
        //case 3: display circles in 2-1 layout (2 on the top, 1 on the bottom)
        case 3:
            HStack(alignment: .top, spacing: 4) {
                VStack(alignment: .leading, spacing: 4) {
                    //top row: 2 circles next to each other
                    HStack(spacing: 4) {
                        matchMarker(peg: 0)
                        matchMarker(peg: 2)
                    }
                    //bottom row: 1 circle next on the left
                    matchMarker(peg: 1)
                }
            }
        
        //case 4: display circles in 2x2 grid layout (2 rows, 2 columns)
        case 4:
            HStack(alignment: .top, spacing: 4) {
                //left column for pegs 0 and 2
                VStack(alignment: .leading, spacing: 4) {
                    matchMarker(peg: 0)
                    matchMarker(peg: 2)
                }
                //right column for pegs 1 and 3
                VStack(alignment: .leading, spacing: 4) {
                    matchMarker(peg: 1)
                    matchMarker(peg: 3)
                }
            }
       
        //case 5: display circles in 3x2 layout (2 rows, 3 columns)
        case 5:
            VStack(alignment: .leading, spacing: 4) {
                //top row: 3 circles arranged horizontally
                HStack(spacing: 4) {
                    matchMarker(peg: 0)
                    matchMarker(peg: 1)
                    matchMarker(peg: 2)
                }
                //bottom row: 2 circles arranged horizontally
                HStack(spacing: 4) {
                    matchMarker(peg: 3)
                    matchMarker(peg: 4)
                }
            }
        
        //Case 6: Display circles in a 3x2 grid layout (2 rows, 3 columns)
        case 6:
            VStack(alignment: .leading, spacing: 4) {
                //top row: 3 circles that are arranged horizontally
                HStack(spacing: 4) {
                    matchMarker(peg: 0)
                    matchMarker(peg: 1)
                    matchMarker(peg: 2)
                }
                //bottom row: 3 circles that are arranged horizontally
                HStack(spacing: 4) {
                    matchMarker(peg: 3)
                    matchMarker(peg: 4)
                    matchMarker(peg: 5)
                }
            }
        
        //default case: fallback for any other array size
        default:
            HStack(spacing: 4) {
                VStack(spacing: 4) {
                    matchMarker(peg: 0)
                    matchMarker(peg: 1)
                }
                VStack {
                    matchMarker(peg: 2)
                }
            }
        }
    }
    
    
    //helper function that creates a single feedback indicator circle
    //parameters  - peg - index of the match to display feedback for
    //returns - a circle view styled based on whether it is an exact, inexact or no match
    func matchMarker(peg: Int) -> some View{
        
        //get the match value at the specified peg index
        let matchValue = matches[peg]
        
                //determine if the circle should be filed - exact match
                let isFilled = matchValue == .exact
        
                //determine if the circle should have a border - match of color, but not position
                let hasBorder = matchValue != .nomatch
            
                //returning circle with conditional styling
                return Circle()
        
                    //filling the circle with the primary color(as of now), where in light mode it is black and white in the dark mode
                    //if isFilled is false, use color.clear to keep the inside empty
                    .fill(isFilled ? Color.primary : Color.clear)
        
                    //adding a border to the circle
                    //if hasBorder is true, draw a 1-point line in the primary color
                    //if false, the border is transparent(no outline)
                    .strokeBorder(hasBorder ? Color.primary : Color.clear, lineWidth: 1)
                    //setting the circle size to 12x12
                    .frame(width: 12, height: 12)
    }
}

#Preview {
    MatchMarkers(matches:[.exact, .exact, .inexact, .inexact, .inexact, .inexact])
}
