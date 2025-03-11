//
//  AddEventDocView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 23/12/24.
//

import SwiftUI

struct AddEventDocView: View {
    @ObservedObject var viewModel: AddEventDocViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var isImagePickerPresented = false
    @State private var showImageOptions = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 24) {
        // Elimino el título interno ya que ahora estará en la barra de navegación
        
        // Campo de texto arriba
        VStack(alignment: .leading) {
            Text("Nombre del evento")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField("Ingrese el nombre del evento", text: $viewModel.eventName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 4)
        }
        .padding(.horizontal)
        
        // Imagen principal que ocupa más espacio
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
                .frame(maxWidth: .infinity)
                .frame(height: 350)
            
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "photo.fill.on.rectangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                    
                    Text("Toque para agregar imagen")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showImageOptions = true
        }
        .confirmationDialog("Seleccionar imagen", isPresented: $showImageOptions) {
            Button("Tomar foto") {
                imageSourceType = .camera
                isImagePickerPresented = true
            }
            
            Button("Seleccionar de galería") {
                imageSourceType = .photoLibrary
                isImagePickerPresented = true
            }
            
            if viewModel.selectedImage != nil {
                Button("Eliminar imagen", role: .destructive) {
                    viewModel.selectedImage = nil
                }
            }
            
            Button("Cancelar", role: .cancel) { }
        }
        
        Spacer()
        
        // Botón de guardar
        Button {
            if viewModel.validateAndSave(to: homeViewModel) {
                // Regresar a la pantalla home
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            Text("Guardar Evento")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(viewModel.isFormValid ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .disabled(!viewModel.isFormValid)
        .padding(.horizontal)
        .padding(.bottom, 20)
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
        }
        .padding(.vertical)
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $viewModel.selectedImage, sourceType: imageSourceType)
        }
        .navigationTitle("Añadir nuevo evento")
        .navigationBarTitleDisplayMode(.inline)
    }
}
