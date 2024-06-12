import SwiftUI

struct GeneretorView: View {
    @ObservedObject var viewModel: ViewModel
    @State var isShowingAdddImageSheet = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Picture")
                .font(.largeTitle)
                .bold()
            Text("generated")
                .font(.largeTitle)
                .bold()
            VStack{
                Text("Choose a style of picture")
                    .font(.title3)
                    .bold()
                AsyncImage(url: viewModel.image){image in
                    image.resizable().aspectRatio(1,contentMode: .fit)
                }placeholder: {
                    ProgressView()
                }
                .background(Color.gray.opacity(0.2))
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .cornerRadius(20)
                .clipped()
                
            }
            Spacer()
           
            Button(action: {
                isShowingAdddImageSheet = true
            }, label: {
                Text("Add Image")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(Capsule())
            })
            .padding()
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .padding()
        .onAppear{
            viewModel.generateImage()
        }
        .sheet(isPresented: $isShowingAdddImageSheet) {
            AddImageSheet(  image: viewModel.image, imageType: viewModel.selectedType)
                }
    }
}

#Preview {
    GeneretorView(viewModel: .init(prompt: "", selectedType: .realism))
}



struct AddImageSheet: View{
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var name: String = ""
    @State private var date: Date = .now
    @State  var image: URL?
    @State  var imageType : ImageType
    @State  var isTitleEmpty: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View{
        NavigationStack{
            Form{
                TextField("Image name", text: $name)
                DatePicker("Date", selection: $date , displayedComponents: .date)   
                VStack {
                    if let image = image {
                    AsyncImage(url: image) { image in
                        image.resizable()
                        .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                            } else {
                                Text("No Image")
                            }
                            Text("Image Type: \(imageType.title)")
                                .font(.title)
                                .bold()
                    Button(action: save, label: {
                        Text("Save")
                    })
                        }
                        .padding()

            }
        }.navigationTitle("Add Image")
           
    }
    
    func save(){
        guard !name.isEmpty else {
                   isTitleEmpty = true
                   DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                       isTitleEmpty = false
                   }
                   return
               }
        isLoading = true
        
        let newImage = ImageModel(title: name, imageData: image!, createdAt:date, imageStyle: imageType.rawValue)
        modelContext.insert(newImage)
        do {
                    try modelContext.save()
                    isLoading = false
                    dismiss()
                } catch {
                    print("Failed to save prayer: \(error.localizedDescription)")
                    isLoading = false
                }
    }
}

