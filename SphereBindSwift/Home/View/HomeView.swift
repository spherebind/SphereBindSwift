//
//  HomeView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 4/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var isDetailViewActive = false
    @State private var isProfileViewActive = false

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Cargando eventos...")
                    .padding()
            } else {
                List {
                    ForEach(viewModel.items) { item in
                        NavigationLink(destination: DetailView(viewModel: DetailViewModel(item: item))) {
                            HStack {
                                if let image = item.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.gray)
                                }

                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.headline)
                                    Text(item.date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteItem)
                }
            }
        }
        .navigationBarTitle("Home", displayMode: .inline)
        .navigationBarItems(
            leading: Button(action: {
                isProfileViewActive.toggle()
            }) {
                Image(systemName: "person.circle")
            },
            trailing: Button(action: {
                isDetailViewActive.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
            }
        )
        .background(
            NavigationLink(
                destination: AddEventDocView(viewModel: AddEventDocViewModel(), homeViewModel: viewModel),
                isActive: $isDetailViewActive
            ) { EmptyView() }
        )
        .background(
            NavigationLink(
                destination: ProfileView(),
                isActive: $isProfileViewActive
            ) { EmptyView() }
        )
        .navigationBarBackButtonHidden(true) // Elimina el botón de volver
    }
}
