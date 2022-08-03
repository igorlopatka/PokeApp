//
//  SplashView.swift
//  PokeApp
//
//  Created by Igor Łopatka on 02/08/2022.
//

import SwiftUI

import SwiftUI

struct SplashView: View {
    
    @State var isAnimating = false
    @State var isActive = false
    
    var body: some View {
        VStack {
            if self.isActive {
                PokemonListView()
            } else {
                ZStack {
                    Image("landscape").resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        Image("pokemon-logo")
                            .resizable()
                            .frame(width: 325.0, height: 200.0, alignment: .top)
                            .scaleEffect(isAnimating ? 1 : 0)
                            .animation(Animation.easeOut(duration: 2), value: isAnimating)
                            .onAppear {
                                self.isAnimating = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                    withAnimation {
                                        self.isActive = true
                                    }
                                }
                            }
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }
            }
        }
    }
}

