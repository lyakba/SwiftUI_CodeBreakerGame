//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Barbara Lyakisheva on 1/15/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            pegs(colors: [.red,.green,.blue,.yellow])
            pegs(colors: [.orange,.blue,.blue,.yellow])
            //pegs
            //pegs
        }
        .padding()
    }
    func pegs(colors: Array<Color>) -> some View{
        HStack {
            
            ForEach(colors.indices, id:\.self){
                index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(colors[index])
            }
            MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
            }
            
        }
    }
        
    #Preview {
        ContentView()
    }
