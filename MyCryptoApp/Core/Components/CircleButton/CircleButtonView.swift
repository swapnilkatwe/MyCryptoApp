//
//  CircleButtonView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 11/04/24.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background {
                Circle()
                    .foregroundColor(Color.theme.background)
            }
            .shadow(color: Color.theme.accent.opacity(0.25),
                    radius: 10, x: 0, y: 0)
            .padding()
    }
}

@available(iOS 17, *)
#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CircleButtonView(iconName: "info")
            .environment(\.colorScheme, .light)

        CircleButtonView(iconName: "heart")
            .environment(\.colorScheme, .dark)
    }

}

/* Preview provider before iOS 17
struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
*/
