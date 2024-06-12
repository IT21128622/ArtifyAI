//
//  UserProfileView.swift
//  ArtifyAI
//
//  Created by Hesara Mahendra on 2024-06-12.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    HStack {
                        Image("profile_picture")
                            .resizable()
                            .frame(width: geometry.size.width * 0.25, height: geometry.size.width * 0.25)
                            .clipShape(Circle())
                            .padding(.leading, 16)
                        Spacer()
                        HStack(spacing: 24) {
                            VStack {
                                Text("Posts")
                                    .font(.headline)
                                Text("120")
                                    .font(.title)
                            }
                            NavigationLink{
                                PromoptView()
                            }
                            label: {
                                Text("New Image")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.trailing, 30)
                    }
                    .padding(.top, 16)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hesara Mahendra")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Bio: This is a sample bio of the user.")
                            .font(.body)
                    }
                    .padding()
                    
                    ScrollView {
                        ViewAllAIModel()
                        }
                        .padding()
                    }
                }
            }
        }
    }


#Preview {
    UserProfileView()
}
