//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Barbara Lyakisheva on 1/15/26.
//

//Importing SwiftUI framework to use its components and views
import SwiftUI

//Defining main contentView struct that conforms to the View protocol
//It is primary view that will be displayed to the user
struct ContentView: View {
    
    //Body is a property that is required by the View protocol
    //Since it defines what contents will be displayed on the screen
    //Must return a View type
    var body: some View {
        
        //VStack arranges its child vertically
        VStack{
            
            //first row of pegs: creates circles with red, green, blue and yellow
            pegs(colors: [.red,.green,.blue,.yellow])
            
            //second row of pegs: creates circles with orange, blue, blue and yellow
            pegs(colors: [.orange,.blue,.blue,.yellow])
            
            //Optional pegs
            //pegs
            //pegs
        }
        //padding adds space around the entire VStack from all edges
        //Creates a margin between the content and the screen edges
        .padding()
    }
    
    //Helper function that creates a single row of circles
    //Parameter 'colors' is an Array of Color values that determines what color each peg should be
    //The function returns 'some View', meaning it returns a SwiftUI view of unknown concrete type
    func pegs(colors: Array<Color>) -> some View{
        
        //HStack arranges its child views horizontally
        HStack {
            
            //ForEach loops through each index in the colors array
            //'colors.indices' creates a range of valid index positions
            //'id:\.self' tells swiftui how to uniquely identify each element though index itself
            ForEach(colors.indices, id:\.self){
                index in
                
                //Rounded rectangle creates a rectangle shape with rounded corners
                RoundedRectangle(cornerRadius: 10)
                
                //aspectRatio - makes the shape of a perfect square
                //1 - width-to-height ratio of 1:1 (square)
                //contentMode - ensures the shape fits within available space
                    .aspectRatio(1, contentMode: .fit)
                
                //foregroundStyle  - colors the spae with the color from the array at the current index
                //example: first shape gets colors[0].red and etc.
                    .foregroundStyle(colors[index])
            }
            
            
            //MatchMaker -  custom component that defines feedback indicators
            //Shows which guesses were: exact(correct color, correct position), inexact(correct color, but wrong position) and nomatch(wrong color, wrong position)
            //in this case 'matches' contains 4 feedback values that correspond to the 4 pegs above
            MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
            }
            
        }
    }
        

//preview is a macro that allows to see how the contentview lookss in xcode's preview canvas w/o the need to run the full app
    #Preview {
        ContentView()
    }
