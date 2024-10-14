//
//  AnimationWinPView.swift
//  SurfProject
//
//  Created by Maud Gauthier on 19/09/2024.
//

import SwiftUI

struct WorkInProgressView: View {
    @State private var moveGradient = true
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.size.width
        
        VStack {
            ZStack {
                // Image en arrière-plan
                Image("swiftiesTeam")
                    .resizable(resizingMode: .tile)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 320)
                
                // Vue animée "Work in Progress"
                Rectangle()
                    .overlay {
                        LinearGradient(colors: [.clear, .blue, .clear], startPoint: .leading, endPoint: .trailing)
                            .frame(width: 70)
                            .offset(x: moveGradient ? -screenWidth/2 : screenWidth/2)
                    }
                    .animation(.linear(duration: 2).repeatForever(autoreverses: false), value:moveGradient)
                    .mask {
                        VStack {
                            Text("Work in Progress...")
                                .font(.custom("Chalkduster", size: 42, relativeTo: .title))
                            Spacer()
                        }
                    }
                    .foregroundColor(.red)
                    .onAppear {
                        self.moveGradient.toggle()
                    }
            }
        }
    }
}

#Preview {
    WorkInProgressView()
}
