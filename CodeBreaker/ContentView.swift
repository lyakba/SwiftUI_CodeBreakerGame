//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Barbara Lyakisheva on 1/15/26.
// updated: 1/16/26

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        //arranging all game rows veritcally with 35 points of spacing
        VStack(spacing: 35){
            
            //row 1
            pegs(colors: [.primary,.primary,.primary], feedback: [.exact, .inexact, .inexact])
            
            //row 2
            pegs(colors: [.primary, .primary, .primary], feedback: [.exact, .nomatch, .nomatch])
            
            //row 3
            pegs(colors: [.primary, .primary, .primary, .primary], feedback: [.exact, .inexact, .exact, .inexact])
            
            //row 4
            pegs(colors: [.primary, .primary, .primary, .primary], feedback: [.exact, .inexact, .exact, .nomatch])
            
            //row 5
            pegs(colors: [.primary, .primary, .primary, .primary], feedback: [.exact, .nomatch, .inexact, .nomatch])
            
            //row 6
            pegs(colors: [.primary, .primary, .primary, .primary, .primary, .primary], feedback: [.exact, .exact, .nomatch, .exact, .inexact, .nomatch])
            
            //row 7
            pegs(colors: [.primary, .primary, .primary, .primary, .primary, .primary], feedback: [.exact, .exact, .inexact, .exact, .inexact, .inexact])
            
            //row 8
            pegs(colors: [.primary, .primary, .primary, .primary, .primary], feedback: [.exact, .inexact, .inexact, .exact, .inexact])
            
            //row 9
            pegs(colors: [.primary, .primary, .primary, .primary, .primary], feedback: [.exact, .inexact, .nomatch, .inexact, .nomatch])
        }
        
        //adding padding around the edges
        .padding(20)
        
        //adding width and alingment
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    //helper function that creates a single row
    //parameters: colors - array of color values, feedback - array of match values that represent the feedback for a guess
    //return - view containing the colored pegs and their corresponding feedback indicators
    func pegs(colors: Array<Color>, feedback: Array<Match>) -> some View{
        //arranging the pegs horizontally with the hstack
        HStack(spacing: 10) {
            //looping through all indicies in the colors array and creating a circle for each peg color
            ForEach(colors.indices, id:\.self){
                index in
                //creating a circle shape for each peg
                Circle()
                    //set the size to 45x45
                    .frame(width: 45, height: 45)
                    //color the circle with the color from the colors array at that index
                    .foregroundStyle(colors[index])
            }
            //display the feedback indicators for that specific row
            //pass the feedback array to matchMarkers which will display the appropriate circles
            MatchMarkers(matches: feedback)
            }
        }
    }

    #Preview {
        ContentView()
    }
