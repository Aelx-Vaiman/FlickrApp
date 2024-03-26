//
//  PickerView.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 12/02/2024.
//

import SwiftUI

struct PickerView: View {
    @ObservedObject var viewModel: MainSearchScreenModel
   
    init(viewModel: MainSearchScreenModel) {
        self.viewModel = viewModel
    }
 
  //  let deviceBg = #colorLiteral(red: 0.7647058824, green: 0.9215686275, blue: 1, alpha: 1)
    
    var body: some View {
        ZStack {
            // Transparent overlay to capture taps outside the picker
            Color.black.opacity(0.001) // Nearly transparent
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    // Toggle the visibility of the picker when tapped outside
                    viewModel.showPicker.toggle()
                }
            
            VStack {
                Spacer()

                Picker(selection: $viewModel.cellsPerRow, label: EmptyView()) {
                    ForEach(1...viewModel.maxNumberOfChoices, id: \.self) { count in
                        Text("\(count)")
                            .foregroundStyle(.accent)
                            .tag(count)
                    }
                }
                .overlay(alignment: .top, content: {
                    Text("IMAGES PER ROW")
                        .font(.subheadline.bold())
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity)
                        .padding(6)
                        .background( Color.theme.secondaryBackground.opacity(0.6))
                        .cornerRadius(10)
                })
                .pickerStyle(.wheel)
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.backgroundColor)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal) // Add horizontal padding
                
                Button(action: {
                    viewModel.showPicker.toggle() // Hide the picker when "Choose" is tapped
                }) {
                    Text("Choose")
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163))
                        .cornerRadius(10)
                        .padding([.leading, .trailing], 8)
                }
            }
        }
        
    }
}

struct PickerView_Previews: PreviewProvider {
    static var viewModel: MainSearchScreenModel{
        let viewModel = MainSearchScreenModel(backgroundColor: Color.theme.background)
        viewModel.showPicker = true
        return viewModel
    }
    static var previews: some View {
        PickerView(viewModel: viewModel)
    }
}
