//
//  SplashScreen.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 19/02/2024.
//

import SwiftUI
import ChocKit

struct SplashScreen: View {
    
    @State private var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if isActive {
                NavigationStack {
                    MainSearchScreen()
                        .safeAreaInset(edge: .bottom, spacing: 20) {
                            bottomView
                        }
                }
            } else {
                SplashView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
    private var bottomView: some View {
        VStack {
            Text("画廊")
                .font(.title3.bold())
                .padding(.top)
                .foregroundColor(Color.theme.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .background(Color.theme.secondaryBackground.opacity(0.6))
        .allowsHitTesting(false)
    }
}

struct SplashView: View {
    var body: some View {
        
        ZStack {
            
            // best place for background setting in ZStack
            Color.purple
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                // App logo
                Image("flickrSpalsh")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                Text("Flickr App")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Spacer()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .padding(.bottom, 50)
            }
            
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
