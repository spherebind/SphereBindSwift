//
//  DetailView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 23/12/24.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var isImagePickerPresented = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        VStack(spacing: 20) {
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray)
            }

            TextField("Ingrese el nombre del evento", text: $viewModel.eventName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            HStack {
                Button("Galería") {
                    imageSourceType = .photoLibrary
                    isImagePickerPresented = true
                }
                .buttonStyle(.bordered)

                Button("Cámara") {
                    imageSourceType = .camera
                    isImagePickerPresented = true
                }
                .buttonStyle(.bordered)
            }

            Button("Guardar") {
                viewModel.validateAndSave(to: homeViewModel)
            }
            .buttonStyle(.borderedProminent)
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Debe ingresar el nombre del evento")
            }
        }
        .padding()
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $viewModel.selectedImage, sourceType: imageSourceType)
        }
    }
}
