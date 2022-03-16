//
//  MoviesViewModel.swift
//  Movies
//
//  Created by MAC on 25/01/22.
//

import Foundation
import Combine

struct PhotoDetail {
    let title: String
    let url: String
}
enum ViewState: Equatable {
    case none
    case loading
    case finishedLoading
    case error(String)
}

protocol MoviesViewModelType {
    var stateBinding: Published<ViewState>.Publisher { get }
    var photoCount:Int { get }
    var photos:[PhotoDetail] { get }
    func searchPhoto(keyword: String, apiRequest:ApiRequest)
//    func markFavourite(isSelected:Bool, index:Int)
//    func showFavouriteMovies()
}

final class MoviesViewModel: MoviesViewModelType {
    
    var stateBinding: Published<ViewState>.Publisher{ $state }
    
    private let repository:MovieRepositoryType
    private var cancellables:Set<AnyCancellable> = Set()
        
    @Published  var state: ViewState = .none

    var photos:[PhotoDetail] = []
    
    var photoCount: Int {
        return photos.count
    }
    
    init(repository:MovieRepositoryType) {
        self.repository = repository
    }

    func searchPhoto(keyword: String, apiRequest:ApiRequest) {
        if keyword.count > 0 {
            searchPhoto(apiRequest: apiRequest)
        }else {
          //  showFavouriteMovies()
     }
    }
    
    private func searchPhoto(apiRequest: ApiRequestType) {
        
        state = ViewState.loading
        let publisher =   self.repository.getMovies(apiRequest: apiRequest)
        
        let cancalable = publisher.sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(_):
                self?.state = ViewState.error("Network Not Availale")
            }
        } receiveValue: { [weak self ] photosDetail in
            self?.photos = photosDetail
            self?.state = ViewState.finishedLoading
        }
        self.cancellables.insert(cancalable)
    }
    
//    func markFavourite(isSelected: Bool, index: Int) {
//        let movie = self.movies[index]
//        movie.isFav = isSelected
//        repository.saveOrRemoveFav(movie: movie)
//    }
//
//    func showFavouriteMovies() {
//
//        let cancalable = repository.fetchFavMovies().sink { completion in
//
//        } receiveValue: { [weak self] movies in
//            self?.movies = movies
//            self?.state = ViewState.finishedLoading
//        }
//
//        self.cancellables.insert(cancalable)
//
//    }
//
    deinit {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
}
