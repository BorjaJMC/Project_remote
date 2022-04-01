//
//  MyRootViewController.swift
//  Proyecto
//
//  Created by Borja Martín on 9/3/22.
//

import UIKit

extension UIImageView {
    func downloadedFrom (url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                
            }
        }.resume()
    }
    
    func downloadedFrom (link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom (url: url, contentMode: mode)
    }
}

class MyRootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let viewTitle = "CARTELERA"

    var films: [FilmData] = []
    var filteredFilms: [FilmData] = []
    
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = viewTitle.uppercased()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let myCellRootNib = UINib(nibName: "CellRootView", bundle: nil)
        
        self.tableView.register(myCellRootNib, forCellReuseIdentifier: "CellRootView")
        
        
        self.tableView.reloadData()
  
        let loadedData = DataLoader()

        loadedData.fetchFilms() { (films) -> () in
            self.films += films.results
            self.filteredFilms += films.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        self.createSearchBar()
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFilms.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellRootView", for: indexPath) as! CellRootView
        cell.backgroundColor = UIColor.white
        
        cell.titleFilm.text = filteredFilms[indexPath.row].title

        let urlString = "https://image.tmdb.org/t/p/w500" + (
            filteredFilms[indexPath.row].poster_path)
        let url = URL(string: urlString)
        cell.imagenRoot.downloadedFrom(url: url!)
        
        return cell
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailViewController.film = filteredFilms[indexPath.row]

        self.navigationController?.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.contentScaleFactor*100
    
    }
    
    func createSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search film"
        navigationItem.searchController = self.searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let q = searchController.searchBar.text?.lowercased() ?? ""
        if q != "" {
            self.filteredFilms = self.films.filter { film in
                if film.title.lowercased().contains(q) {
                    return true
                } else {
                    return false
                }
            }
        } else {
            self.filteredFilms = self.films
        }
        self.tableView.reloadData()
        
    }

}
