//
//  SettingsView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 25/04/24.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultUrl: URL = URL(string: "https://www.google.com")!
    let youTubeUrl: URL = URL(string: "https://www.youtube.com")!
    let personalUrl: URL = URL(string: "https://www.github.com/swapnilkatwe")!
    let coinGekoUrl: URL = URL(string: "https://www.coingeko.com")!
    
    var body: some View {
        NavigationStack {
            List {
                settingSectionUrlsSection
                coinGekoSection
                developerSection
                applicationSection
            }
            .font(.headline)
            .tint(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButton()
                }
            }
        }
    }
}


extension SettingsView {
    
    private var settingSectionUrlsSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0 ))
                Text("This app is made to demonstrate MVVM, Combine and core data")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link(destination: defaultUrl, label: { Text("Google Search ✌️") })
            Link(destination: youTubeUrl, label: { Text("youtube Search ✌️") })
        } header: {
            Text("Search")
        }
    }
    
    private var coinGekoSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25.0 ))
                Text("The crypto currancy data comes from free api coingecko.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link(destination: coinGekoUrl, label: { Text("Visit Coin Gecko ✌️") })

        } header: {
            Text("Coin Geko")
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 10) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0 ))
                Text("I am swapnil, It uses SwiftUI, project benifits from multi threading, publishers, Subscribers, persistance")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link(destination: personalUrl, label: { Text("My Github Projects✌️") })

        } header: {
            Text("Developer")
        }
    }
    
    private var applicationSection: some View {
        Section {
            Link(destination: defaultUrl, label: { Text("Terms & Servise✌️") })
            Link(destination: defaultUrl, label: { Text("Privacy policy✌️") })
            Link(destination: defaultUrl, label: { Text("Company Website ✌️") })
            Link(destination: defaultUrl, label: { Text("Learn more✌️") })
        } header: {
            Text("Application")
        }
    }
}
#Preview {
    SettingsView()
}
