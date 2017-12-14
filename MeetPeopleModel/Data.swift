/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Datas {
	public var region : Int?
	public var is_online : Bool?
	public var unread_num : Int?
	public var video_call_waiting : Bool?
	public var is_fav : Int?
	public var voice_call_waiting : Bool?
	public var call_waiting : Int?
	public var long : Double?
	public var last_login : Int?
	public var user_name : String?
	public var abt : String?
    public var age : Int?
    public var ava_id : String?
    public var gender : Int?
    public var user_id : String?
    public var lat : Double?
    public var dist : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let data_list = Data.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Data Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Datas]
    {
        var models:[Datas] = []
        for item in array
        {
            models.append(Datas(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let data = Data(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Data Instance.
*/
	required public init?(dictionary: NSDictionary) {

		region = dictionary["region"] as? Int
		is_online = dictionary["is_online"] as? Bool
		unread_num = dictionary["unread_num"] as? Int
		video_call_waiting = dictionary["video_call_waiting"] as? Bool
		is_fav = dictionary["is_fav"] as? Int
		voice_call_waiting = dictionary["voice_call_waiting"] as? Bool
		call_waiting = dictionary["call_waiting"] as? Int
		long = dictionary["long"] as? Double
		last_login = dictionary["last_login"] as? Int
		user_name = dictionary["user_name"] as? String
		abt = dictionary["abt"] as? String
		age = dictionary["age"] as? Int
        ava_id = dictionary["ava_id"] as? String
        gender = dictionary["gender"] as? Int
        user_id = dictionary["user_id"] as? String
        lat = dictionary["lat"] as? Double
        dist = dictionary["dist"] as? Int
    }
		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.region, forKey: "region")
		dictionary.setValue(self.is_online, forKey: "is_online")
		dictionary.setValue(self.unread_num, forKey: "unread_num")
		dictionary.setValue(self.video_call_waiting, forKey: "video_call_waiting")
		dictionary.setValue(self.is_fav, forKey: "is_fav")
		dictionary.setValue(self.voice_call_waiting, forKey: "voice_call_waiting")
		dictionary.setValue(self.call_waiting, forKey: "call_waiting")
		dictionary.setValue(self.long, forKey: "long")
		dictionary.setValue(self.last_login, forKey: "last_login")
		dictionary.setValue(self.user_name, forKey: "user_name")
		dictionary.setValue(self.abt, forKey: "abt")
		dictionary.setValue(self.age, forKey: "age")
        dictionary.setValue(self.ava_id, forKey: "ava_id")
        dictionary.setValue(self.gender, forKey: "gender")
        dictionary.setValue(self.user_id, forKey: "user_id")
        dictionary.setValue(self.lat, forKey: "lat")
        dictionary.setValue(self.dist, forKey: "dist")
        return dictionary
    }

}
