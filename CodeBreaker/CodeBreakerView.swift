//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Barbara Lyakisheva on 1/15/26.
// updated: 1/24/26

import SwiftUI

struct CodeBreakerView: View{
    let game: CodeBreaker = CodeBreaker(masterCode: )
    
    var body: some View{
        VStack{
            pegs(colors: [.red, .green, .orange, .yellow])
            pegs(colors: [.red, .green, .green, .yellow])
        }
        .paddding()
    }
    func pegs(colors: Array<Color>) -> some View{
        HStack{
            ForEach(colors.indices, id: \.self){
                index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(colors[index])
            }
            MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
        }
    }
}

#Preview {
    CodeBreakerView()
}
