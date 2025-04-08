//
//  PromptManager.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 18/3/25.
//

import Foundation
import FirebaseVertexAI

struct PromptManager {
    
    private static let vertex = VertexAI.vertexAI()
    private static let modelName = "gemini-2.0-flash"

    static func makeQuestion(_ prompt: String) async -> String {
        do {
            // Inicializa el modelo generativo con el modelo especificado
            let model = vertex.generativeModel(modelName: modelName)
            
            // Genera contenido basado en el prompt
            let fullPrompt = Prompt.subject + prompt
//            let fullPrompt = "Hola Gemina! Quien es KEVINHO MORALES"
            let response = try await model.generateContent(fullPrompt)
            
            // Retorna el texto generado o un mensaje de error si la respuesta es nula
            return response.text ?? "No se generó ninguna respuesta."
        } catch {
            // Manejo de errores para evitar fallos en la ejecución
            print("Error al generar respuesta: \(error.localizedDescription)")
            return "Ocurrió un error al procesar la solicitud."
        }
    }
}
