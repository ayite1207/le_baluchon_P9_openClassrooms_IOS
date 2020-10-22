
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
    "coord": {
        "lon": 2.35,
        "lat": 48.85
    },
    "weather": [
        {
            "id": 803,
            "main": "Clouds",
            "description": "nuageux",
            "icon": "04d"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 285.46,
        "feels_like": 283.57,
        "temp_min": 284.82,
        "temp_max": 286.48,
        "pressure": 1023,
        "humidity": 76
    },
    "visibility": 10000,
    "wind": {
        "speed": 2.1,
        "deg": 250
    },
    "clouds": {
        "all": 75
    },
    "dt": 1602499851,
    "sys": {
        "type": 1,
        "id": 6550,
        "country": "FR",
        "sunrise": 1602482799,
        "sunset": 1602522421
    },
    "timezone": 7200,
    "id": 2988507,
    "name": "Paris",
    "cod": 200
}
""".data(using: .utf8)!


let temps = try JSONDecoder().decode(Weather.self, from: json)

print(temps.clouds["all"])

//for contact in product.results{
//    print(contact.location.street.number)
//}

