//
//  EndPoints.swift
//  Movies
//
//  Created by MAC on 25/01/22.
//

import Foundation

//https://api.themoviedb.org/3/search/movie?api_key=3215a185b25eb297a66e63d137fb994f&language=en-US&query=Star

//https://image.tmdb.org/t/p/w300/lV5OpzAss1z06YNagOVap1I35mH.jpg?api_key=3215a185b25eb297a66e63d137fb994f

// https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=0e08e76eff544231b992197c7c7c22a9&text=cat&format=json&nojsoncallback=1

// https://live.staticflickr.com/65535/51880456842_bd33d5c1c8_w.jpg
struct EndPoint {
    static let baseUrl = "https://www.flickr.com/"
    static let imagesBaseUrl = "https://live.staticflickr.com/"
}

struct Path {
    static let movies = "services/rest/"
}

