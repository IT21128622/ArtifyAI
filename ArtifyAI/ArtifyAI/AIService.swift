import Foundation
import Alamofire

class AIService {
    private let endpoint = "https://api.openai.com/v1/images/generations"
    
    func generateImage(prompt: String) async throws -> String {
        let body = AIImageBody(prompt: prompt, size: "512x512")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIAPIKey)"
        ]
        
        let response = try await AF.request(endpoint, method: .post, parameters: body, encoder: .json, headers: headers)
            .serializingDecodable(AIImageResponse.self).response
        
        switch response.result {
        case .success(let value):
            guard let imageUrl = value.data.first?.url else {
                throw NSError(domain: "AIService", code: 1, userInfo: [NSLocalizedDescriptionKey: "No image URL found in the response"])
            }
            return imageUrl
        case .failure(let error):
            if let data = response.data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                print("Error Response JSON: \(json)")
            }
            throw error
        }
    }
}

struct AIImageResponse: Decodable {
    let data: [AIImageResult]
}

struct AIImageResult: Decodable {
    let url: String
}

struct AIImageBody: Encodable {
    let prompt: String
    let size: String
}
