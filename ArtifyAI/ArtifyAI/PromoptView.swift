//
//  ContentView.swift
//  ArtifyAI
//
//  Created by Hesara Mahendra on 2024-06-09.
//

import SwiftUI

struct PromoptView: View {
    @State var selectedStyle = ImageType.allCases[0]
    @State var promptText: String = ""
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading ){
                Text("Select Options")
                    .font(.largeTitle)
                    .bold()
                Text("Choose a style of picture")
                    .font(.title3)
                    .bold()
                GeometryReader{ reader in
                    ScrollView(.horizontal,
                               showsIndicators: false){
                        HStack{
                            ForEach(ImageType.allCases,
                                    id: \.self){
                                imagetype in
                                Button{
                                    selectedStyle = imagetype
                                }
                            label:{
                                ZStack(alignment: .bottom ){
                                    
                                    Image(imagetype.rawValue)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(
                                            width: reader.size.width * 0.4,
                                            height: reader.size.width * 0.4 * 1.4
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    Rectangle()
                                        .fill(Color.black.opacity(0.5))
                                        .frame(height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                                    VStack {
                                        // Spacer()
                                        Text(imagetype.title)
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                }
                                .frame(width:
                                        reader.size.width * 0.4,
                                       height:
                                        reader.size.width * 0.4 * 1.4)
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue, lineWidth: imagetype == selectedStyle ? 5 : 0 ))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                                
                            }
                        }
                    }
                }
                Text("Enter your prompt")
                    .font(.title3)
                    .bold()
                TextEditor(text: $promptText)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(12)
                    .tint(Color.blue)
                VStack(alignment: .center){
                    NavigationLink{
                        GeneretorView(viewModel: .init(prompt: promptText, selectedType: selectedStyle))
                    } label:{
                        Text("Generate")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }
                }
                .frame(maxWidth: .infinity)
                 
            }
            .padding()
        }
        }
    }


#Preview {
    PromoptView()
}
