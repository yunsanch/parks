//
//  ContentView.swift
//  Parks
//
//  Created by Yunior Sanchez on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var parks: [Park] = []

    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(parks) { park in
                        NavigationLink(value: park) { // <-- Pass in the park associated with the park row as the value
                            ParkRow(park: park) // <-- The park row serves as the label for the NavigationLink
                        }
                        
                    }
                }
            }
            .navigationDestination(for: Park.self) { park in // <-- Add a navigationDestination that reacts to any Park type sent from a Navigation Link
                ParkDetailView(park: park) // <-- Create a ParkDetailView for the destination, passing in the park
            }
            .navigationTitle("National Parks") // <-- Add a navigation bar title
            .padding()
            
            .onAppear(perform: {
                Task {
                    await fetchParks()
                }
            })
        }
    }

            private func fetchParks() async {
                // URL for the API endpoint
                // 👋👋👋 Make sure to replace {YOUR_API_KEY} in the URL with your actual NPS API Key
                let url = URL(string: "https://developer.nps.gov/api/v1/parks?q=ca&api_key=DVEuOb5jMvrB3Tibcd9A7pnAanXiaHBx2X701djy")!
                do {

                    // Perform an asynchronous data request
                    let (data, _) = try await URLSession.shared.data(from: url)

                    // Decode json data into ParksResponse type
                    let parksResponse = try JSONDecoder().decode(ParksResponse.self, from: data)

                    // Get the array of parks from the response
                    let parks = parksResponse.data

                    // Print the full name of each park in the array
                    for park in parks {
                        print(park.fullName)
                    }

                    // Set the parks state property
                    self.parks = parks

                } catch {
                    print(error.localizedDescription)
                }
            }
}

#Preview {
    ContentView()
}

//curl -X GET "https://developer.nps.gov/api/v1/parks?q=ca&api_key=DVEuOb5jMvrB3Tibcd9A7pnAanXiaHBx2X701djy" -H "accept: application/json"
