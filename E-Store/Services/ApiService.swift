//
//  ApiService.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 04/11/23.
//
import Foundation
import UIKit
import Moya
import RxSwift

class ApiService {
    //untuk menyimpan infromasi akses token
    private let accessTokenStore: AccessTokenStore
    
    static let shared: ApiService = ApiService(accessTokenStore: AccessTokenStore.shared)
    private init(accessTokenStore: AccessTokenStore) {
        self.accessTokenStore = accessTokenStore
    }
    
    private lazy var apiProvider: MoyaProvider<Api> = {
        let configuration = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        return MoyaProvider<Api>(
            requestClosure: authorizeRequest,
            plugins: [NetworkLoggerPlugin(configuration: configuration)]
            )
        
    }()
    
    //untuk mengelola objek2 yang akan dilepaskan ketika instance dari 'ApiService' di-deinit
    private let disposeBag = DisposeBag()
    
    //fungsi untuk mengautorisasi permintaan ke endpoint tertentu, menerima sebuah endpoint dan closure 'done' akan dipanggil setelah proses autorisasi selesai
    func authorizeRequest(endpoint: Endpoint, done: @escaping (Result<URLRequest, MoyaError>) -> Void){
        do {
            //membuat URLRequest dari endpoint yg diberikan
            var urlRequest = try endpoint.urlRequest()
            
            //mengambil akses token dari 'accessTokenStore' dan jika ada, menambahkannya sebagai header Authorization ke dalam URLRequest
            let accessToken = accessTokenStore.accessToken
            if let accessToken = accessToken?.accessToken {
                urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            done(.success(urlRequest))
            
        }catch {
            done(.failure(MoyaError.underlying(error, nil)))
        }
    }
    
    func login(username: String, password: String, completion: @escaping (Result<Void, Error>) -> Void){
        apiProvider.rx.request(.login(username, password))
            .map(AccessToken.self) //responnya akan berisi data yang dapat di-decode menjadi objek 'AccessToken'
            .subscribe { event in //menangani event yang dikirim oleh permintaan jaringan
                switch event {
                case .success(let accessToken):
                    self.accessTokenStore.accessToken = accessToken
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                    
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    func loadProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        apiProvider.rx.request(Api.profile)
            .map(Profile.self)
            .subscribe { event in
                switch event {
                case .success(let profile):
                    completion(.success(profile))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            .disposed(by: disposeBag)
    }
    
    //networking api dengan moya rx
    func loadCategories(completion: @escaping (_ categories: [Category], Error?) -> Void){
        apiProvider.rx.request(Api.categories)
            .map([Category].self)
            .subscribe { event in
                switch event {
                case .success(let categories):
                    completion(categories, nil)
                case .failure(let error):
                    completion([], error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func loadProducts(categoryId: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        apiProvider.rx.request(Api.products(categoryId))
            .map([Product].self)
            .subscribe { event in
                switch event {
                case .success(let products):
                    completion(.success(products))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            .disposed(by: disposeBag)
    }

    
    //networking api manual
//    func loadCategories(completion: @escaping (_ categories: [Category], Error?) -> Void) {
//        let url = URL(string: BASE_URL)
//        let request = URLRequest(url: url!)
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let jsonData = data {
//                do{
//                    let categories = try JSONDecoder().decode([Category].self, from: jsonData)
//                    DispatchQueue.main.async {
//                        completion(categories, error)
//                    }
//                    
//                } catch {
//                    print(String(describing: error))
//                    DispatchQueue.main.async {
//                        completion([], error)
//                    }
//                }
//                
//            } else {
//                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Categories data is nil"])
//                DispatchQueue.main.async {
//                    completion([], error)
//                }
//            }
//        }
//        task.resume()
//        
//    }
    
//    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
//        if let url = URL(string: urlString) {
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: url)
//                DispatchQueue.main.async {
//                    if let imageData = data {
//                        let image = UIImage(data: imageData)
//                        completion(image)
//                    } else {
//                        completion(nil)
//                    }
//                }
//            }
//        } else {
//            completion(nil)
//        }
//    }
//    
}
