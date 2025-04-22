//
//  HomeViewModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 23/12/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

final class HomeViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    @Published var isLoading: Bool = true

    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    init() {
        fetchItems()
    }

    func addItem(title: String, image: UIImage?) {
        let newID = UUID().uuidString
        let date = getCurrentDate()
        var newItem = ItemModel(id: newID, title: title, date: date, imageURL: nil)

        if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
            let imageRef = storage.reference().child("eventImages/\(newID).jpg")
            imageRef.putData(imageData, metadata: nil) { _, error in
                if let error = error {
                    print("Error al subir la imagen: \(error.localizedDescription)")
                    return
                }
                imageRef.downloadURL { url, _ in
                    if let url = url {
                        newItem.imageURL = url.absoluteString
                        self.saveItemToFirestore(item: newItem)
                    }
                }
            }
        } else {
            saveItemToFirestore(item: newItem)
        }
    }

    private func saveItemToFirestore(item: ItemModel) {
        do {
            try db.collection("events").document(item.id).setData(from: item)
            DispatchQueue.main.async {
                self.items.append(item)
            }
        } catch {
            print("Error al guardar el evento: \(error)")
        }
    }

    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            db.collection("events").document(item.id).delete { error in
                if let error = error {
                    print("Error al eliminar: \(error.localizedDescription)")
                } else {
                    DispatchQueue.main.async {
                        self.items.remove(at: index)
                    }
                }
            }
        }
    }

    func fetchItems() {
        isLoading = true
        db.collection("events").getDocuments { snapshot, error in
            if let error = error {
                print("Error al obtener eventos: \(error.localizedDescription)")
                self.isLoading = false
                return
            }

            guard let documents = snapshot?.documents else { return }

            var loadedItems: [ItemModel] = []

            let group = DispatchGroup()

            for document in documents {
                do {
                    var item = try document.data(as: ItemModel.self)
                    if let imageURL = item.imageURL {
                        group.enter()
                        self.downloadImage(from: imageURL) { uiImage in
                            item.image = uiImage
                            loadedItems.append(item)
                            group.leave()
                        }
                    } else {
                        loadedItems.append(item)
                    }
                } catch {
                    print("Error al parsear item: \(error)")
                }
            }

            group.notify(queue: .main) {
                self.items = loadedItems
                self.isLoading = false
            }
        }
    }

    private func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }

    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }
}
