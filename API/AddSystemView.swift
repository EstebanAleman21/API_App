//
//  AddSystemView.swift
//  API
//
//  Created by Esteban Aleman on 18/04/24.
//

import SwiftUI


struct AddBodySystemView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: BodySystemsViewModel

    @State private var systemName: String = ""
    @State private var description: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("System Name", text: $systemName)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add New System", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    viewModel.addBodySystem(system_name: systemName, description: description)
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

