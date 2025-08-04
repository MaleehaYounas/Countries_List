
import Foundation

class Network {
    
    func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
      
        guard let url = URL(string: urlString)
        else {
            completion(.failure(URLError(.badURL)))
            return
        }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let decodedCountries = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedCountries))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }

        dataTask.resume()
    }
}
