//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Barbara Lyakisheva on 1/16/26.
//

//Importing SwiftUI framework to use its components and views
import SwiftUI


//Defining an enum -> enumeration named 'Match' that represent the three possible feedback states
//Enum - set of related values that a variable can be
//In my case, each peg in a guess can have one of three states mentioned below
enum Match{
    
    //wrong color that does not appear anywhere
    case nomatch
    
    //user got the color and the location right
    case exact
    
    //user gor the color, but not the location
    case inexact
}


//Define the MatchMakers struct that conforms to the View Protocol
//This displays feedback indicators - small circles - showing how close the guess is to the secret code
struct MatchMarkers: View{
    
    //Property that stores an array of Match values
    //Each element corresponds to feedback for one of the four pegs in the guess
    var matches: [Match]
    
    //the body is the property that is required by the view protocol
    //it defines what indicators will be displayed
    var body: some View{
        
        //Arranging the views horizontally
        HStack{
            
            //First column of feedback circles(left side)
            //Arranges its children vertically
            VStack{
                
                //feedback for the first and second peg
                matchMarker(peg: 0)
                matchMarker(peg: 1)
            }
            
            //First column of feedback circles(left side)
            //Arranges its children vertically
            VStack{
                //feedback for the third and fourth peg
                matchMarker(peg: 2)
                matchMarker(peg: 3)
            }
        }
    }
    
    //helper function that creates a single feedback circle
    //parameter peg is the index of which peg's feedback is being displayed
    //it returns a view that will be displayed as a feedback indicator
    func matchMarker(peg: Int) -> some View{
        
        //counts how many matches in the array have exact case -> exact matches
        let exactCount: Int = matches.count(where: {match in match == .exact})
        
        //counts how many matches are NOT .nomatch -> counts both .exact and .inexact
        //tells how many begs were right color, regardless of the position
        let foundCount: Int = matches.count(where: {match in match != .nomatch})

        
        //returns a circle shape with conditional styling based on the counts above
        return Circle()
        
            //fill -> colors the inside of the circle
            //if exactCount > peg -> fill the circle with primary color (depends on the mode)
            //otherwise -> make it transparent, so the inside is empty
            .fill(exactCount > peg ? Color.primary : Color.clear)
        
            //strokeBorder -> draws a colored outline/border around the circle
            //if foundCount > peg: draw a border with the primary color
            // Otherwise: make the border transparent (Color.clear) so no outline appears
            //lineWidth - means the border line thickness
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
        
            //aspectRation -> makes the circle a perfect square
            //1 - width-to-height ratio of 1:1 (circle/square)
            //contentMode - ensures it fits within available space
            .aspectRatio(1, contentMode: .fit)
    }
}

//Displays preview of this view in XCode
#Preview {
    MatchMarkers(matches:[.exact, .inexact, .nomatch])
}
