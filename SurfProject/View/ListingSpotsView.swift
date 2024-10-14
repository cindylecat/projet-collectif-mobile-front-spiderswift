//
//  ListingApiView.swift
//  SurfProject
//
//  Created by Maud Gauthier on 17/09/2024.
//

import SwiftUI

struct ListingSpotsView: View {
    // On observe le ViewModel
    @StateObject private var viewModel = SurfSpotDetailViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Chargement...") // Affichage pendant le chargement
            } else if viewModel.surfSpotDetails.isEmpty {
                Text("Aucune donnée disponible") // Si les données sont vides
            } else {
                List(viewModel.surfSpotDetails) { spot in
                    NavigationLink(destination: DetailsSpotsView(spot: spot)) {
                        HStack {
                            Image(spot.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())

                            VStack(alignment: .leading) {
                                Text(spot.name)
                                    .font(.custom("Chalkduster", size: 18))
                                Text(spot.city)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                .navigationTitle("Spots de Surf")
            }
        }
        .onAppear {
            viewModel.fetchSurfSpots()  // Lancement de la récupération des données
        }
    }
}

// Prévisualisation du code
#Preview {
    ListingSpotsView()
}
