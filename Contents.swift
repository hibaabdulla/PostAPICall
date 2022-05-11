import UIKit

func makePostRequest(){
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        return
    }
    print("Making API Call....")
    
 var request = URLRequest(url: url)
    
//    method,body,header
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String: AnyHashable] = [
        "userId": 1,
        "title": "Hello World",
        "body": "Learn ios App development using Swift and Objective C.",
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
//    Make the request
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            return
        }
        
        do{
            let response = try JSONDecoder().decode(Response.self, from: data)
            print("Success\(response)")
        }
        catch{
            print(error)
        }
    }
    task.resume()
}

struct Response: Codable {
    let body: String
    let id: Int
    let title: String
    let userId: Int
}

makePostRequest()
