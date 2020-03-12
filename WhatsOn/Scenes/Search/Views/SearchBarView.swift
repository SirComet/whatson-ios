//
//  SearchBarView.swift
//  What'sOn
//
//  Created by Maxime Maheo on 12/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    
    // MARK: - Properties
    @State private var searchText: String = ""
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .leading) {
            if searchText.isEmpty {
                Text("Search a movie, people ...")
                    .foregroundColor(Color(.lightGrey800))
            }
            
            TextField("", text: $searchText)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(Color(.darkGrey600))
        .cornerRadius(25)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
            .previewLayout(.fixed(width: 375, height: 50))
    }
}
