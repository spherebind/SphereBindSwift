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
        ScrollView {
            VStack(spacing: 24) {
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
            .padding(.bottom, 40) // Espacio extra para evitar que el teclado cubra elementos
        }
        .background(Color.clear) // Hace que el fondo sea transparente
        .onTapGesture {
            hideKeyboard() // Oculta el teclado al tocar cualquier parte de la vista
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $viewModel.selectedImage, sourceType: imageSourceType)
        }
        .navigationTitle("Añadir nuevo evento")
        .navigationBarTitleDisplayMode(.inline)
        .modifier(KeyboardAvoiding())
    }
}

// MARK: - Extensión para ocultar el teclado al tocar fuera del TextField
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Modificador para evitar que el teclado empuje la vista
struct KeyboardAvoiding: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onAppear {
                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillShowNotification,
                    object: nil,
                    queue: .main
                ) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        keyboardHeight = keyboardFrame.height - 40
                    }
                }

                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillHideNotification,
                    object: nil,
                    queue: .main
                ) { _ in
                    keyboardHeight = 0
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            }
    }
}
