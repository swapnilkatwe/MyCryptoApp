//
//  XmarkButton.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 17/04/24.
//

import SwiftUI

struct XmarkButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            dismiss.callAsFunction()
        } label: {
                Image(systemName: "xmark")
                .font(.headline)
        }    }
}

#Preview {
    XmarkButton()
}
