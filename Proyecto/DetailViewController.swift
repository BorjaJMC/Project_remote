//
//  DetailViewController.swift
//  Proyecto
//
//  Created by Borja Martín on 9/3/22.
//

import UIKit


extension UIImageView {
    func detailDownloadedFrom (url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
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
    
    func detaildownloadedFrom (link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom (url: url, contentMode: mode)
    }
}
    
class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var detailImage: UIImageView!
    
    var film: FilmData?
    var filmData: [FilmMetaData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = film?.title
        self.filmData = [
            FilmMetaData.init(label: "Descripción", value: film?.overview)
        ]

        let urlString = "https://image.tmdb.org/t/p/w500" + (film!.poster_path)
        let url = URL(string: urlString)
        self.detailImage.detailDownloadedFrom(url: url!)
        
        let myCellDetailNib = UINib(nibName: "CellDetailView", bundle: nil)
        
        self.detailTableView.register(myCellDetailNib, forCellReuseIdentifier: "CellDetailView")
        
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
        
        self.detailTableView.reloadData()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmData!.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "CellDetailView", for: indexPath)
        
        
        if let cellDetail = cell as? CellDetailView {
            cellDetail.referenceLabel.text = filmData![indexPath.row].label
            cellDetail.mainLabel.text = filmData![indexPath.row].value
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
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
