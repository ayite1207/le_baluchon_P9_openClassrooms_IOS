import Foundation

struct Currency: Codable{
    let success : Bool
    let timestamp : Int
    let base : String
    let date : String
    let rates : [String : Double]
}


let json = """
{
    "success": true,
    "timestamp": 1602425045,
    "base": "EUR",
    "date": "2020-10-11",
    "rates": {
        "USD": 1.183085
    }
}
""".data(using: .utf8)!


let product = try JSONDecoder().decode(Currency.self, from: json)

print(product.rates["USD"]!)

