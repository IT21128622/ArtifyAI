import Foundation
import Combine


extension GeneretorView{
    class ViewModel: ObservableObject{
        @Published var duration = 0
        @Published var image: URL?
        
        let prompt: String
        let selectedType: ImageType
        
        private let aiService =  AIService()
        
        init(prompt: String, selectedType: ImageType ){
            self.prompt = prompt
            self.selectedType = selectedType
        }
    
        func generateImage(){
            let formattedPrompt = "\(selectedType.title) image of \(prompt)"
            
            Task {
                do {
                    let imageUrlString = try await aiService.generateImage(prompt: formattedPrompt)
                    guard let imageUrl = URL(string: imageUrlString) else {
                        print("Failed to generate image")
                        return
                    }
                    await MainActor.run {
                        self.image = imageUrl
                    }
                } catch {
                    print("Error generating image: \(error)")
                }
            }
        }
        
        
    }
}
