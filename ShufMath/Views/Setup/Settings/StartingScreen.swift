//
//  StartingScreen.swift
//  edutainment
//
//  Created by Salman Z on 12/23/24.
//

import SwiftUI
struct StartingScreen: View {
    @ObservedObject var viewModel: GameViewModel
        
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 30){
                if !viewModel.activeGame {
                    GameSetupView(viewModel: viewModel)
                    
                    IconLabel(
                        action: {viewModel.safeStartGame()},
                        buttonText: "Shuffle",
                        color: Color.clear,
                        image: "shuffle"
                    )
                    .playButtonView(gameLock: viewModel.gameLock)
                    
                    Spacer()
                }
            }
            .padding(.top, geometry.size.height * 0.1)
        }
        .edgesIgnoringSafeArea(.top)
    }
}



#Preview {
    StartingScreen(viewModel: GameViewModel())
}
