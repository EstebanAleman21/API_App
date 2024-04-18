//
//  ContentView.swift
//  API
//
//  Created by Esteban Aleman on 18/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BodySystemsViewModel()
    @State private var showingAddSystemView = false

    var body: some View {
        NavigationView {
            List(viewModel.bodySystems) { system in
                VStack(alignment: .leading) {
                    Text(system.system_name).font(.headline)
                    Text(system.description).font(.subheadline)
                }
            }
            .navigationTitle("Body Systems")
            .onAppear {
                viewModel.fetchBodySystems()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddSystemView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSystemView) {
                AddBodySystemView(viewModel: viewModel)
            }
        }
    }
}


#Preview {
    ContentView()
}
