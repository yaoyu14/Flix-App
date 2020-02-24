//
//  TrailerViewController.swift
//  Flix
//
//  Created by Yao Yu on 2/23/20.
//  Copyright © 2020 Yao Yu. All rights reserved.
//

import UIKit
import WebKit
class TrailerViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var movie: [String: Any]!
    var movies = [[String:Any]]()

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*if let result = movie["results"] as? [[String: Any]] {
            let id = result[0]
            let key = id["key"]
              let myURL = URL(string:"https://www.youtube.com/watch?v=\(key)")
                     let myRequest = URLRequest(url: myURL!)
                     webView.load(myRequest)
        }*/
        let id = movie["id"]
        print(id)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
               let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
               let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
               let task = session.dataTask(with: request) { (data, response, error) in
                  // This will run when the network request returns
                  if let error = error {
                     print(error.localizedDescription)
                  } else if let data = data {
                     let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let idDictionary = dataDictionary["id"] as! [String: Any]
                   self.movies = idDictionary["results"] as! [[String:Any]]
                     // TODO: Get the array of movies
                     // TODO: Store the movies in a property to use elsewhere
                     // TODO: Reload your table view data
                    print(dataDictionary)
                  }
               }
               task.resume()
        
      //  let myURL = URL(string:"https://www.youtube.com/watch?v=\(key)")
             //  let myRequest = URLRequest(url: myURL!)
             //  webView.load(myRequest)
        
       //print(movie["id"])
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
