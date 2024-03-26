//
//  SearchView.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 16/02/2024.
//

import SwiftUI
import ChocKit

struct SearchView: View {
    @ObservedObject var viewModel: MainSearchScreenModel
    
    init(viewModel: MainSearchScreenModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 8) {
            SearchBarView(searchText: $viewModel.searchText, backgroundColor: viewModel.backgroundColor.opacity(viewModel.showPicker ? 0.3 : 1), style: .shadow())
            
            // Option Button
            Button(action: {
                viewModel.showPicker.toggle() // Toggle the visibility of the picker
            }) {
                Image("threeDots")
                    .font(.title)
                    .foregroundColor(.accent)
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: MainSearchScreenModel(backgroundColor: Color.theme.background))
            .previewLayout(.sizeThatFits)
    }
}
