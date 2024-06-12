import SwiftUI
import SwiftData
 
struct ViewAllAIModel: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var modelContext
    @Query var genImage: [ImageModel]
    @State private var selectedImage: ImageModel? = nil
    @State private var isSheetPresented: Bool = false

    var body: some View {
        if genImage.isEmpty {
            Text("No Image Found")
            .font(.headline)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .padding()
        } else {
            LazyHGrid(rows: [GridItem(.fixed(100))]) {
                ForEach(genImage, id: \.title) { image in
                    HStack {
                        Button(action: {
                            selectedImage = image
                            isSheetPresented.toggle()
                        }) {
                            AsyncImage(url: image.imageData) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                    //.clipped()
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                @unknown default:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                }
                            }
                            
                        }.sheet(isPresented: $isSheetPresented) {
                            if let selectedImage = selectedImage {
                                ImageDetailsView(image: selectedImage, onDelete: { deleteImage(image) })
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    func deleteImage(_ image: ImageModel) {
           modelContext.delete(image)
       }
    
    init(searchString: String = "", sortOrder: [SortDescriptor<ImageModel>] = []) {
        _genImage = Query(filter: #Predicate { genImg in
            if searchString.isEmpty {
                true
            } else {
                genImg.title.localizedStandardContains(searchString)
            }
        }, sort: sortOrder)
    }

}
 
struct ImageDetailsView: View {
    let image: ImageModel
    let onDelete: () -> Void

    var body: some View {
        VStack {
            Text("Image Details")
                .font(.title)
                .padding()
            Text(image.title)
            Button("Delete") {
                onDelete()
            }
            .foregroundColor(.red)
            .padding()
        }
    }
}
#Preview {
    ViewAllAIModel()
}
