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
  
  @ObservedObject var obs = Observer()
  
  var body: some View {
    NavigationView {
      List(obs.datas) { i in
        Card(name: i.name, url: i.url)
      } .navigationBarTitle("JSON Parse")
    }
    
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
    AF.request("https://api.github.com/users/hadley/orgs").responseData { (data) in
      let json = try! JSON(data:data.data!)
      
      for i in json {
        self.datas.append(DataType(id: i.1["id"].intValue, name: i.1["login"].stringValue, url: i.1["avatar_url"].stringValue))
        
        print(i.1["node_id"].stringValue)
      }
      
    }
  }
}
// Here 0 represent the number of indexes in json
// 1 represents the json data of each index...
// in this json data im going to extract only three attributes
// you can extract any attributes u want...
// u can retrieve any json attribute by simply changing this...

struct DataType: Identifiable {
  
  var id: Int
  var name: String
  var url: String
  
}

struct Card: View {
  
  var name = ""
  var url = ""
  
  var body: some View {
    HStack {
      AnimatedImage(url:URL(string: url)!).resizable().frame(width: 60, height: 60).clipShape(Circle()).shadow(radius: 20)
      
      Text(name).fontWeight(.heavy)
      
    }
  }
}
