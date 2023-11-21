//
//  RSSViewModel.swift
//  SwiftRSS
//
//  Created by Angelos Staboulis on 20/11/23.
//

import Foundation
import SWXMLHash
import UIKit
class RSSViewModel:NSObject,ObservableObject{
    func showRSS(rssString:String) async -> [RSSModel]{
        return await withCheckedContinuation { checked in
            DispatchQueue.main.async{
                    let urlMain = URL(string:rssString)
                    guard let urlNew = urlMain else { return }
                    let request = URLRequest(url: urlNew)
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        do{
                            guard let dataNew = data else { return }
                            let parseXML = String(data: dataNew, encoding: .utf8)
                            let xml = XMLHash.parse(parseXML!)
                            var rssArray:[RSSModel] = []
                            for item in try xml.byKey("rss").byKey("channel").byKey("item").all{
                                rssArray.append(RSSModel(title: try item.byKey("title").element!.text, link: try item.byKey("link").element!.text, pubDate: try item.byKey("pubDate").element!.text))
                            }
                            checked.resume(returning: rssArray)
                        }catch{
                            debugPrint("Something went wrong!!!!!")
                        }
                        
                    }.resume()
                    
            }
        }

    }
}
