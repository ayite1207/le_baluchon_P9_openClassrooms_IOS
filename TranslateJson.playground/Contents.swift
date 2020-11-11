import Foundation

struct Translate : Codable {
    var data : Data
    
}

struct Data : Codable{
    var translations : [Text]
}

struct Text : Codable{
    var translatedText : String
    var detectedSourceLanguage : String
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

let translate = try JSONDecoder().decode(Translate.self, from: json)

print(translate.data.translations[0].translatedText)

//for contact in product.results{
//    print(contact.location.street.number)
//}

