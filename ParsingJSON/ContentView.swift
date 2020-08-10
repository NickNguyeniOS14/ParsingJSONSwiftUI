//
//  ContentView.swift
//  ParsingJSON
//
//  Created by Nick Nguyen on 8/9/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Alamofire
import SwiftyJSON



struct ContentView: View {
    var body: some View {
        Text("Hello, world!").padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



class Observer: ObservableObject {
  @Published var datas = [DataType]()
  
  init() {
    AF.request("https://api.github.com//users/hadley/orgs").responseData { (data) in
      let json = JSON(data:data.data!)
      
      for i in json {
        print(i.0)
      }
      
    }
  }
}
// Here 0 represent the number of indexes in json
// 1 represents the json data of each index...

struct DataType: Identifiable {
  
  var id: String
  var name: String
  var url: String
  
}
