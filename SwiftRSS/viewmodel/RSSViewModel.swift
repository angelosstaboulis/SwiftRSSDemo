//
//  RSSViewModel.swift
//  SwiftRSS
//
//  Created by Angelos Staboulis on 20/11/23.
//

import Foundation
import SWXMLHash
class RSSViewModel:NSObject,ObservableObject{
    func showRSS(rssString:String) async -> [RSSModel]{
        return await withCheckedContinuation { checked in
            DispatchQueue.main.async{
                    let urlMain = URL(string:rssString)
                    let request = URLRequest(url: urlMain!)
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        do{
                            let parseXML = String(data: data!, encoding: .utf8)
                            let xml = XMLHash.parse(parseXML!)
                            var rssArray:[RSSModel] = []
                            for item in try xml.byKey("rss").byKey("channel").byKey("item").all{
                                rssArray.append(RSSModel(title: try item.byKey("title").element!.text, link: try item.byKey("link").element!.text, pubDate: try item.byKey("pubDate").element!.text))
                            }
                            checked.resume(returning: rssArray)
                        }catch{
                            debugPrint("something went wrong!!!!")
                        }
                        
                    }.resume()
                    
            }
        }

    }
}
