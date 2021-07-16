//
//  ContentView.swift
//  JSONCoding
//
//  Created by Ben Stone on 7/16/21.
//

import SwiftUI

struct User: Codable {
  let name: String
  let age: Int
}

struct ContentView: View {
  @State var name: String = "iOS User"
  @State private var age = 50.0
  @State var encodedUserData: Data? = nil
  @State var consoleMessage = ""
  
  var body: some View {
    Form {
      TextField("Name", text: $name)
      VStack {
        Slider(value: $age, in: 0...100, step: 1)
        Text("Age: " + Int(age).description)
      }
      Button("Encode and save user") {
        let newUser = User(name: name, age: Int(age))
        do {
          let encodedUser = try JSONEncoder().encode(newUser)
          encodedUserData = encodedUser
          consoleMessage =
            """
            Encoded a user
            JSON: \(String(data: encodedUser, encoding: .utf8)!)
            """
        }
        catch {
          print(error)
        }
      }
      if let encodedUserData = encodedUserData {
        Button("Decode saved user") {
          do {
            let savedUser = try JSONDecoder().decode(User.self, from: encodedUserData)
            consoleMessage =
              """
              Decoded a saved user:
              Swift Struct: \(savedUser)
              """
          }
          catch {
            print(error)
          }
        }
      }
      VStack {
        Text("""
          Output:
          
          \(consoleMessage)
          """
          )
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
