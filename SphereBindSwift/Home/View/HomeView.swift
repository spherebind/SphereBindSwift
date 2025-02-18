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
        NavigationView {
            VStack {
                if viewModel.items.isEmpty {
                    Text("No hay elementos o ítems")
                        .foregroundColor(.gray)
                        .font(.title)
                        .padding()
                } else {
                    List(viewModel.items) { item in
                        HStack {
                            Image(uiImage: item.image ?? UIImage(systemName: "photo")!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
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
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    isProfileViewActive.toggle()
                }) {
                    Image(systemName: "person.circle")
                        .font(.title)
                },
                trailing: Button(action: {
                    isDetailViewActive.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
            )
            .background(
                NavigationLink(
                    destination: DetailView(viewModel: DetailViewModel(), homeViewModel: viewModel),
                    isActive: $isDetailViewActive
                ) { EmptyView() }
            )
            .background(
                NavigationLink(
                    destination: ProfileView(),
                    isActive: $isProfileViewActive
                ) { EmptyView() }
            )
        }
        .navigationBarBackButtonHidden(true) // Elimina el botón de volver
    }
}
