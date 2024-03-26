import SwiftUI
import UIKit

struct ColorfulTabBar: View {
    
    @State private var selectedTab: ColorfulTabBarItem = .home
    
    var body: some View {
        CustomTabView(tabBarView: ColorfulTabBarsView(selection: $selectedTab), tabs: ColorfulTabBarItem.allCases, selection: selectedTab) {
            NavigationView {
                FirstScreen()
                    .navigationBarTitle("Home")
            }
            
            NavigationView {
                ZStack {
                    Color.blue
                    VStack {
                        Text("Favorites")
                            .navigationBarTitle("Favorites")
                    }
                }
              
            }
            
            NavigationView {
                ZStack {
                    Color.green
                    VStack {
                        Text("Profile")
                            .navigationBarTitle("Profile")
                    }
                }
            }
            

                ZStack {
                    Color.orange.ignoresSafeArea()
                    VStack {
                        Text("Massages")
                            .navigationBarTitle("Massages")
                    }
                }
            
        }
    }
    
}


struct FirstScreen: View {
    var body: some View {
        ZStack {
            Color.red
            VStack {
                NavigationLink(destination: NextScreen()) {
                    Text("Button")
                }
                .padding()
            }
            
        }
    }
}

struct NextScreen: View {
    @State var text = ""
    var body: some View {
        ZStack {
            Color.indigo.opacity(0.5).background(ignoresSafeAreaEdges: .top)
            VStack() {
                Spacer()
                NavigationLink(destination: FirstScreen()) {
                    Text("Button")
                }
                
                Spacer()
                TextField("hello u all", text: $text)
                    .frame(height: 50)
                    .background(.green)
                    .padding()
                    
            }
        }
    }
}

struct ColorfulTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ColorfulTabBar()
    }
}
