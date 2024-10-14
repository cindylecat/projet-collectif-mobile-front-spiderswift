//
//  ViewModel.swift
//  SurfProject
//
//  Created by Maud Gauthier on 25/09/2024.
//

import Foundation
import Combine

class SurfSpotDetailViewModel: ObservableObject {
    @Published var surfSpotDetails: [SurfSpotDetail] = []
    @Published var isLoading: Bool = true
    @Published var selectedSpot: SurfSpotDetail?
    
    private var cancellables = Set<AnyCancellable>()
    
    // Initialiser ViewModel et lancer la récupération des données
    init() {
        fetchSurfSpots()
    }
    
    // Fonction pour récupérer les spots de surf
    func fetchSurfSpots() {
        // L'URL de l'API
        guard let url = URL(string: "http://localhost:8080/surfspots") else {
                    print("URL invalide")
                    return
                }
        
        // Créer la requête
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Créer la tâche de requête
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Erreur: \(error.localizedDescription)")
                return
            }
            
            // Vérifier le code de statut HTTP
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Réponse serveur invalide")
                return
            }
            
            // Traiter les données reçues
            if let data = data {
                do {
                    let jsonResponse = try JSONDecoder().decode([SurfSpotDetail].self, from: data)
                    DispatchQueue.main.async {
                        self.surfSpotDetails = jsonResponse
                        self.isLoading = false
                    }
                } catch {
                    print("Erreur lors du décodage JSON: \(error.localizedDescription)")
                }
            }
        }
        
        // Lancer la requête
        task.resume()
    }
}

