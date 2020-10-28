import Foundation

struct Weather: Codable {
    var coord : [String : Double]
    var weather : [Data]
    var base : String
    var main : [String : Double]
    var visibility : Int
    var wind : [ String : Double]
    var clouds : [String : Int]
    var dt : Int
    var sys : System
    var timezone : Int
    var id : Int
    var name : String
    var cod : Int
}

struct Data: Codable {
    var id :Int
    var main : String
    var description : String
    var icon : String
}

struct System: Codable {
    var type : Int
    var id : Int
    var country : String
    var sunrise : Int
    var sunset : Int
}

let json = """
{
    "data": {
        "translations": [
            {
                "translatedText": "it is raining",
                "detectedSourceLanguage": "fr"
            }
        ]
    }
}
""".data(using: .utf8)!


let temps = try JSONDecoder().decode(Weather.self, from: json)

print(temps.clouds["all"])

//for contact in product.results{
//    print(contact.location.street.number)
//}

