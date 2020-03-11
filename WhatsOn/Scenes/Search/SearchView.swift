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
        Text("Hello, World from SwiftUI !")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModelPreview())
    }
}
