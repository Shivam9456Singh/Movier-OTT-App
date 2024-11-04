//
//  YouTubeSearchResponse.swift
//  Movier
//
//  Created by Shivam Kumar on 23/10/24.
//

import Foundation

/* Youtube API dataModel
 items =     (
             {
         etag = xxYiAnBVnmMcZHWpibOuon8BrQw;
         id =             {
             kind = "youtube#video";
             videoId = "mMgWo0mY-54";
         };
         kind = "youtube#searchResult";
     },
 
 */

struct YouTubeSearchResponse : Codable {
    let items : [VideoElement]
}

struct VideoElement : Codable {
    let id : IdVideoElement
}

struct IdVideoElement : Codable {
    let kind : String
    let videoId : String
}
