//
//  APIViewModel.swift
//  API
//
//  Created by Esteban Aleman on 18/04/24.
//

import Foundation


struct BodySystem: Identifiable, Codable {
    var id: Int
    var system_name: String
    var description: String
}

class BodySystemsViewModel: ObservableObject {
    @Published var bodySystems: [BodySystem] = []
    @Published var errorMessage: String?

    let baseURL = "http://localhost:3000/api/body-systems"

    func fetchBodySystems() {
        guard let url = URL(string: baseURL) else {
            self.errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                
                do {
                    self.bodySystems = try JSONDecoder().decode([BodySystem].self, from: data)
                } catch {
                    self.errorMessage = "Data decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    func addBodySystem(system_name: String, description: String) {
        guard let url = URL(string: baseURL) else {
            self.errorMessage = "Invalid URL"
            return
        }

        let bodySystem = BodySystem(id: 0, system_name: system_name, description: description)
        guard let uploadData = try? JSONEncoder().encode(bodySystem) else {
            self.errorMessage = "Error encoding data"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = uploadData

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Failed to post data: \(error.localizedDescription)"
                    return
                }
                self?.fetchBodySystems()  // Reload data after posting
            }
        }.resume()
    }

}
