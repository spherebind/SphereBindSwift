//
//  DetailViewModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 11/3/25.
//

import SwiftUI
import Vision
import FirebaseVertexAI

final class DetailViewModel: ObservableObject {
    @Published var item: ItemModel
    @Published var recognizedText: String = ""
    @Published var responseAI: String = ""
    @Published var isProcessing: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    init(item: ItemModel) {
        self.item = item
    }
    
    func recognizeText() {
        guard let image = item.image, let cgImage = image.cgImage else {
            showError(message: "No se puede procesar la imagen")
            return
        }
        
        isProcessing = true
        recognizedText = "Procesando..."
        
        let textRecognitionRequest = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.isProcessing = false
                    self.showError(message: "Error al reconocer texto: \(error.localizedDescription)")
                }
                return
            }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                DispatchQueue.main.async {
                    self.isProcessing = false
                    self.showError(message: "No se pudieron procesar los resultados")
                }
                return
            }
            
            let recognizedText = observations.compactMap { observation in
                observation.topCandidates(1).first?.string
            }.joined(separator: "\n")
            
            DispatchQueue.main.async {
                self.isProcessing = false
                if recognizedText.isEmpty {
                    self.recognizedText = "No se encontró texto en la imagen"
                } else {
//                    self.recognizedText = recognizedText
                    self.generateCode(from: recognizedText)
                }
            }
        }
        
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = true
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        do {
            try requestHandler.perform([textRecognitionRequest])
        } catch {
            DispatchQueue.main.async {
                self.isProcessing = false
                self.showError(message: "Error al procesar la imagen: \(error.localizedDescription)")
            }
        }
    }
    
    private func generateCode(from text: String) {
        Task {
            let prompt = "Genera código basado en el siguiente texto: \n\(text)"
            let response = await PromptManager.makeQuestion(text)
            
            DispatchQueue.main.async { [self] in
                recognizedText = response
            }
        }
    }
    
    private func showError(message: String) {
        errorMessage = message
        showError = true
    }
}
