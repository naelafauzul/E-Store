//
//  AccessTokenStore.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 21/12/23.
//

import Foundation
import Valet
//library valet digunakan untuk pengelolaan data sensitif keychain di platform Apple

class AccessTokenStore {
    static let shared: AccessTokenStore = AccessTokenStore()
    private init() { }
    
    //deklarasi properti dg lazy = tidak akan diinisialisasi jika tidak digunakan
    private lazy var valet: Valet = {
        return Valet.valet(with: Identifier(nonEmpty: Bundle.main.bundleIdentifier)!, accessibility: .whenUnlocked) //diakses ketika perangkat ter-unlock
    }()
    
    private let accessTokenKey = "kAccessTokenKey"
    
    var accessToken: AccessToken? {
        //mengambil data akes token
        get {
            //valet digunakan utk mengambil objek dari keychain, jika berhasil disimpan di 'data'
            if let data = try? valet.object(forKey: accessTokenKey) {
                //jika berhasil maka data akan di decode dan return AccessToken
                return try? JSONDecoder().decode(AccessToken.self, from: data)
            } else {
                //jika gagal maka return nil
                return nil
            }
        }
        set {
            //memeriksa apakah newValue nil atau tidak
            if let accessToken = newValue {
                //encode akses token jadi data lalu disimpa di let data
                if let data = try? JSONEncoder().encode(accessToken) {
                    //jika encode berhasil 'data' disimpan ke dalam keychain
                    try? valet.setObject(data, forKey: accessTokenKey)
                }
            } else {
                //handle jika nil atau tidak berhasil maka token sebelumnya dihapus, tidak disimpan
                try? valet.removeObject(forKey: accessTokenKey)
            }
        }
    }
}

