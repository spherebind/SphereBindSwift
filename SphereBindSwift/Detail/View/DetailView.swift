//
//  DetailView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 11/3/25.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            // Imagen principal
            if let image = viewModel.item.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .shadow(radius: 5)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray)
                    .padding()
            }
            
            // Área de texto reconocido
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Texto Reconocido:")
                            .font(.headline)
                            .padding(.leading)
                        
                        Spacer()
                        
                        if viewModel.isProcessing {
                            ProgressView()
                                .padding(.trailing)
                        }
                    }
                    
                    Text(viewModel.recognizedText)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                .padding(.horizontal)
                        )
                        .animation(.default, value: viewModel.recognizedText)
                }
            }
            .frame(maxHeight: .infinity)
            
            Spacer()
            
            // Botón para generar texto
            Button {
                viewModel.recognizeText()
            } label: {
                HStack {
                    Image(systemName: "text.viewfinder")
                    Text("Generar Texto")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .disabled(viewModel.isProcessing)
            .padding(.bottom)
        }
        .navigationTitle(viewModel.item.title)
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
