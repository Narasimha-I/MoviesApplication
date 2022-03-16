//
//  ViewController.swift
//  Movies
//
//  Created by MAC on 24/01/22.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var bindings = Set<AnyCancellable>()
    
    let viewModel:MoviesViewModelType = MoviesViewModel(repository: MovieRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupBindings()
    }
    
    private func setupBindings() {
        bindSearchTextFieldToViewModel()
        bindViewModelState()
    }

    private func bindViewModelState() {
      let cancellable =  viewModel.stateBinding.sink { completion in
            
        } receiveValue: { [weak self] launchState in
            DispatchQueue.main.async {
                self?.updateUI(state: launchState)
            }
        }
        self.bindings.insert(cancellable)
    }
    
    private func bindSearchTextFieldToViewModel() {
        searchTextField.textPublisher
             .debounce(for: 0.5, scheduler: RunLoop.main)
             .removeDuplicates()
             .sink { [weak self] in
                 let apiRequest = ApiRequest(baseUrl: EndPoint.baseUrl, path: Path.movies, params: ["method":"flickr.photos.search", "api_key": "0e08e76eff544231b992197c7c7c22a9","text":$0, "format":"json", "nojsoncallback":"1"])

                 self?.viewModel.searchPhoto(keyword: $0, apiRequest: apiRequest)
             }
             .store(in: &bindings)
    }
    
    private func updateUI(state:ViewState) {
        switch state {
        case .none:
            tableView.isHidden = true
        case .loading:
            tableView.isHidden = true
            activityIndicator.startAnimating()
        case .finishedLoading:
            tableView.isHidden = false
            activityIndicator.stopAnimating()
            tableView.reloadData()
        case .error(let error):
            activityIndicator.stopAnimating()
            tableView.reloadData()
            self.showAlert(message:error)
        }
    }
}

extension MoviesViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photoCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.setData(photo: viewModel.photos[indexPath.row], index: indexPath.row)
        return cell
    }
}


extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let movie = viewModel.photos[indexPath.row]
//        let detailsViewModel = MovieDetailsViewModel(movie: movie)
//        if  let detailsVC = UIStoryboard.init(name:"Main", bundle:nil).instantiateViewController(withIdentifier:"MovieDetailsViewController") as? MovieDetailsViewController {
//            detailsVC.viewModel = detailsViewModel
//
//            self.navigationController?.pushViewController(detailsVC, animated: true)
//        }
    }
}


extension MoviesViewController: MovieCellDelegate {
    func favAction(isSelected: Bool, index: Int) {
//        viewModel.markFavourite(isSelected: isSelected, index: index)
    }
}
