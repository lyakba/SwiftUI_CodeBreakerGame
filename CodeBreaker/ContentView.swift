//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Barbara Lyakisheva on 1/15/26.
// updated: 1/16/26

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 35){
            pegs(colors: [.primary,.primary,.primary], feedback: [.exact, .inexact, .inexact])
            pegs(colors: [.primary, .primary, .primary], feedback: [.exact, .nomatch, .nomatch])
            pegs(colors: [.primary, .primary, .primary, .primary], feedback: [.exact, .inexact, .exact, .inexact])
            pegs(colors: [.primary, .primary, .primary, .primary], feedback: [.exact, .inexact, .exact, .nomatch])
            pegs(colors: [.primary, .primary, .primary, .primary], feedback: [.exact, .nomatch, .inexact, .nomatch])
            pegs(colors: [.primary, .primary, .primary, .primary, .primary, .primary], feedback: [.exact, .exact, .nomatch, .exact, .inexact, .nomatch])
            pegs(colors: [.primary, .primary, .primary, .primary, .primary, .primary], feedback: [.exact, .exact, .inexact, .exact, .inexact, .inexact])
            pegs(colors: [.primary, .primary, .primary, .primary, .primary], feedback: [.exact, .inexact, .inexact, .exact, .inexact])
            pegs(colors: [.primary, .primary, .primary, .primary, .primary], feedback: [.exact, .inexact, .nomatch, .inexact, .nomatch])
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func pegs(colors: Array<Color>, feedback: Array<Match>) -> some View{
        HStack(spacing: 10) {
            ForEach(colors.indices, id:\.self){
                index in
                Circle()
                    .frame(width: 45, height: 45)
                    //.aspectRatio(contentMode: .fit)
                    .foregroundStyle(colors[index])
            }
            MatchMarkers(matches: feedback)
            }
        }
    }

    #Preview {
        ContentView()
    }
