//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Barbara Lyakisheva on 1/16/26.
//

import SwiftUI

enum Match{
    case nomatch
    case exact
    case inexact
}

struct MatchMarkers: View{
    var matches: [Match]
    var body: some View{
        
        switch self.matches.count{
        case 3:
            HStack(alignment: .top, spacing: 4) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        matchMarker(peg: 0)
                        matchMarker(peg: 2)
                    }
                    matchMarker(peg: 1)
                }
            }
            
        case 4:
            HStack(alignment: .top, spacing: 4) {
                VStack(alignment: .leading, spacing: 4) {
                    matchMarker(peg: 0)
                    matchMarker(peg: 2)
                }
                VStack(alignment: .leading, spacing: 4) {
                    matchMarker(peg: 1)
                    matchMarker(peg: 3)
                }
            }
            
        case 5:
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    matchMarker(peg: 0)
                    matchMarker(peg: 1)
                    matchMarker(peg: 2)
                }
                HStack(spacing: 4) {
                    matchMarker(peg: 3)
                    matchMarker(peg: 4)
                }
            }
            
        case 6:
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    matchMarker(peg: 0)
                    matchMarker(peg: 1)
                    matchMarker(peg: 2)
                }
                HStack(spacing: 4) {
                    matchMarker(peg: 3)
                    matchMarker(peg: 4)
                    matchMarker(peg: 5)
                }
            }

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
    
    func matchMarker(peg: Int) -> some View{
        let matchValue = matches[peg]
                let isFilled = matchValue == .exact
                let hasBorder = matchValue != .nomatch

                return Circle()
                    .fill(isFilled ? Color.primary : Color.clear)
                    .strokeBorder(hasBorder ? Color.primary : Color.clear, lineWidth: 1)
                    .frame(width: 12, height: 12)
    }
}

#Preview {
    MatchMarkers(matches:[.exact, .exact, .inexact, .inexact, .inexact, .inexact])
}
