//
//  SearchBarView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 16/04/24.
//

import SwiftUI

/*
    We Could use Environmental object to get ViewModel,
    but then this view will be allowedv to use when environmentObject is available.
    So To reuse view, we used binding here
*/
struct SearchBarView: View {

    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .keyboardType(.asciiCapable) // Auto suggesion was not getting removed for .default keyboardtype so this is small trick
                .autocorrectionDisabled(true)
                .foregroundStyle(Color.theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding() // Increated size to increase tapable area
                        .offset(x: 10.0)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                    )
            
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10)
        )
        .padding()
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
}
