//
//  DataServices.swift
//  MeetPeopleModel
//
//  Created by Anh Hao on 12/13/17.
//  Copyright © 2017 Anh Hao. All rights reserved.
//

import Foundation
typealias JSON = Dictionary<AnyHashable, Any>
class DataServices {
    static let shared: DataServices = DataServices()
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
    
    func getData() {
        let parameters = ["filter":2,"skip":0,"lower_age":18,"distance":4,"is_new_login":false,"sort_type":1,"region":[],"api":"meet_people","token":"7da15673-cf66-4c08-bc46-6a4a7f3e4ffb","upper_age":120,"take":24
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
                        NotificationCenter.default.post(name: .data, object: nil)
                    }
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
}
extension Notification.Name {
    static let data = Notification.Name.init("data")
}
