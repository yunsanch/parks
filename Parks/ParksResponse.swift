//
//  ParksResponse.swift
//  Parks
//
//  Created by Yunior Sanchez on 3/20/24.
//

import Foundation

struct ParksResponse: Codable {
    let data: [Park]
}

struct Park: Codable, Identifiable, Hashable, Equatable { // <-- Add Hashable and Equatable protocols
    let id: String
    let fullName: String
    let description: String
    let latitude: String
    let longitude: String
    let images: [ParkImage]
    let name: String
    
    static func == (lhs: Park, rhs: Park) -> Bool {
            // Compare only the IDs for equality. If IDs are unique, this is sufficient.
            return lhs.id == rhs.id
            
            // If you decide to compare more properties for equality, you can add them here.
            // For example, to compare both IDs and names:
            // return lhs.id == rhs.id && lhs.name == rhs.name
        }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Hash by id, assuming it's unique
        // If you want to take more properties into account for hashing, add them here.
        // hasher..combine(name)
    }
  }

  struct ParkImage: Codable, Identifiable, Equatable { // <-- Add Equatable protocol
      let title: String
      let caption: String
      let url: String

      var id: String {
          url
      }
  }
