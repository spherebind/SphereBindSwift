//
//  DetailListView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 22/4/25.
//

import SwiftUI

struct DetailListView: View {
    @StateObject var viewModel: DetailListViewModel

    @State private var showSendConfirmation = false

    var body: some View {
        VStack {
            List {
                ForEach($viewModel.people) { $person in
                    VStack(alignment: .leading, spacing: 5) {
                        TextField("Nombre", text: $person.name)
                            .font(.headline)
                        TextField("Apellido", text: $person.lastName)
                            .font(.headline)
                        TextField("Email", text: $person.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
                .onDelete { indexSet in
                    viewModel.people.remove(atOffsets: indexSet)
                }
            }
            Button {
                showSendConfirmation = true
            } label: {
                HStack {
                    Image(systemName: "paperplane")
                    Text("Enviar a Bevy")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .alert("¿Estás seguro que quieres enviar a Bevy?", isPresented: $showSendConfirmation) {
                Button("Enviar", role: .destructive) {
                    viewModel.sendToBevy()
                }
                Button("Cancelar", role: .cancel) { }
            }
        }
        .navigationTitle("Listado de Personas")
        .navigationBarTitleDisplayMode(.inline)
    }
}
