//
//  SearchView.swift
//  What'sOn
//
//  Created by Maxime Maheo on 11/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct SearchView<T>: View where T: SearchViewModelContract {
    
    // MARK: - Properties
    @ObservedObject var viewModel: T
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recherche")
                .fontWeight(.bold)
                .font(.largeTitle)
                .foregroundColor(.white)
            
            SearchBarView()
        }
        .padding(16)
        .background(Color(.darkGrey900))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModelPreview())
    }
}
