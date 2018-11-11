//
//  ApiService.swift
//  Fun App
//
//  Created by Victor Zhang on 11/11/18.
//  Copyright © 2018 Victor Zhang. All rights reserved.
//
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class ApiService {
    
    //api urls
    private let urlStr = "https://s3-ap-southeast-2.amazonaws.com/bridj-coding-challenge/events.json"
    var baseImageUrl:String!
    
    enum APIError : Error {
        case RuntimeError(String)
    }
    
    private func request(_ method: HTTPMethod, _ path: String) -> DataRequest {
        return Alamofire.request("\(path)", method: method, parameters: nil, encoding: JSONEncoding.default, headers: nil)
    }
    
    //MARK: requestImage
    private func requestImage(_ method: HTTPMethod, _ path: String, _ parameters: Parameters?) -> DataRequest {
        let fullURLStr:String =  "\(path)"
        let safeURL:String = fullURLStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        return Alamofire.request("\(safeURL)", method: method, parameters: nil, encoding: JSONEncoding.default, headers: nil)
    }
    
    //MARK: get Company List
    func getEvents(success: @escaping (EventsAPIResponse) -> (), failure: @escaping (Error) -> ()) {
        let finalURL = "\(urlStr)"
        request(.get, finalURL).responseString { (response: DataResponse<String>) in
            switch response.result {
            case .success(let json):
                do {
                    if let data = json.data(using: .utf8) {
                        if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let profile = Mapper<EventsAPIResponse>().map(JSON: jsonDict ) {
                                success(profile)
                            }
                            else {
                                throw APIError.RuntimeError("Json Malformed")
                            }
                        }
                    }
                } catch (let error){
                    failure(error)
                    print(error.localizedDescription)
                }
            case .failure (let error):
                failure(error)
                print(error.localizedDescription)
            }
        }
        
    }
    
    //MARK: getimage
    func getImage(imagePath: String, success: @escaping (UIImage) -> (), failure: @escaping (Error) -> ()) {
        print("url: \(imagePath)")
        requestImage(.get, "\(imagePath)", nil).responseData { (response:DataResponse<Data>) in
            switch response.result {
            case .success(let json):
                do {
                    if !json.isEmpty {
                        if let image =  UIImage(data:json as Data){
                            success(image)
                        }
                        else{
                            throw APIError.RuntimeError("No Image Found")
                        }
                    }
                } catch (let error){
                    failure(error)
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                failure(error)
            }
        }
    }
}
