//
//  DataServices.swift
//  MeetPeopleModel
//
//  Created by Anh Hao on 12/13/17.
//  Copyright © 2017 Anh Hao. All rights reserved.
//

import Foundation
import UIKit
typealias JSON = Dictionary<AnyHashable, Any>
class DataServices {
    static let shared: DataServices = DataServices()
//    private var _imageID: String?
//    var imageID: String {
//        get {
//            if _imageID == nil {
//                getData()
//            }
//            return _imageID ?? ""
//        }
//        set {
//            _imageID = newValue
//        }
//    }
    
    private var _name:String?
    var name: String {
        get {
            if _name == nil {
                getData()
            }
            return _name ?? ""
        }
        set {
            _name = newValue
        }
    }
    private var _imageURL:String?
    var imageURL: String {
        get {
            if _imageURL == nil {
            }
            return _imageURL ?? ""
        }
        set {
            _imageURL = newValue
        }
    }
    var urlArray = [String]()
    func getData() {
        let parameters = ["filter":2,"skip":0,"lower_age":18,"distance":4,"is_new_login":false,"sort_type":1,"region":[],"api":"meet_people","token":"526385c5-939d-42b7-b2a9-3b35f038b3d4","upper_age":120,"take":24
            ] as [String : Any]
        guard let url = URL(string: "http://stg.api.switch-app.net:9119") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let jsons = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
                    let jsonFormatter = Json4Swift_Base(dictionary: jsons! as NSDictionary)
                    for dataUser in (jsonFormatter?.data!)! {
                       self._name = dataUser.user_name
                       self._imageURL = dataUser.ava_id
                        NotificationCenter.default.post(name: .data, object: nil)
                    }
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    func getURl(imageID: String) {
        let baseUrl = "http://stg.api.switch-app.net:9117/api=load_img"
        var urlString = baseUrl
        var parameter : Dictionary<String, String> = [:]
        parameter["token"] = "526385c5-939d-42b7-b2a9-3b35f038b3d4"
        parameter["img_id"] = imageID
        parameter["img_kind"] = "1"
        
        for (key,value) in parameter {
            urlString += "&" + key + "=" + value
        }
        if imageID != "" {
        self.urlArray.append(urlString)
        } else {
            self.urlArray.append("")
        }
    }
}
extension Notification.Name {
    static let data = Notification.Name.init("data")
}
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
}
}
