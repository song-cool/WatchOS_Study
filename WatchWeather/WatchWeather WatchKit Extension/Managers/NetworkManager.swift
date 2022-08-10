//
//  NetworkManager.swift
//  WatchWeather WatchKit Extension
//
//  Created by 송시원 on 2022/08/10.
//

import Foundation

// 제네릭 네트워크 메니저를만들 예정임. api를 받아와서 재사용가능하게 할것임. 기본을 만들고 응답용과 읽기용을 만들것임

final class NetworkManager<T: Codable> {
    func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.badResponse))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.wrongStatusCode(code: httpResponse.statusCode)))
                return
            }
            
            guard  let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(json))
                }
            } catch let err {
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
            
        }
        .resume()
    }
}

// 제너릭으로 만들고자 이넘으로 처리함.
enum NetworkError: Error {
case badResponse
case wrongStatusCode(code: Int)
case error(err: String)
case decodingError(err: String)
    case emptyData
}
