//
//  ProductsController.swift
//  SAA-App
//
//  Created by SAHIL AGASHE on 13/07/24.
//

import UIKit

class ProductsController: UIViewController {
    
    private static let cellReuseIdentifier = "Cell"
    
    private var products = [Product]()
    
    private lazy var myTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        tv.rowHeight = 100
        tv.separatorStyle = .none
        
        // Self refers type
        // Both Self.cellReuseIdentifier and ProductsController.cellReuseIdentifier are same
        tv.register(ProductCell.self, forCellReuseIdentifier: ProductsController.cellReuseIdentifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(myTableView)
        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            myTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        
        getProducts { [weak self] products in
            print("DEBUG is main queue => \(Thread.isMainThread)")
            DispatchQueue.main.async {
                print("DEBUG is main queue inside DispatchQueue.main.async => \(Thread.isMainThread)")
                var arr = products
                for _ in 1...10 {
                    arr += arr
                }
                self?.products = arr
                self?.myTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ProductsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellReuseIdentifier, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
        cell.lbl1.text = product.title
        cell.lbl2.text = product.description
        
        // image loading without using cache
//
//        // loader image
//        cell.imgView.image = UIImage(named: "loader_image")
//        
//        // downloading image
//        getImage(from: product.image) { image in
//            DispatchQueue.main.async {
//                // After downloading image
//                cell.imgView.image = image
//            }
//        }
        
        // image loading using cache
        cell.imgView.loadImage(from: product.image)
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension ProductsController: UITableViewDelegate {
    
}

// MARK: - Using Completion Handlers
extension ProductsController {
    
    func getProducts(completion: @escaping([Product]) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            print("DEBUG: Guard let url error")
            return
        }
        
        let urlSessionDataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in

            if let error {
                print("DEBUG: Error while url session => \(error.localizedDescription)")
                return
            }
            
            guard let data else {
                print("DEBUG: Unable to get data from url!")
                return
            }
            
            guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
                print("DEBUG: Unable to decode data into products!")
                return
            }
            completion(products)
        }
        
        urlSessionDataTask.resume()
    }
    
    func getImage(from urlString: String, completion: @escaping(UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let urlSessionDataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error {
                print("DEBUG: Error while url session => \(error.localizedDescription)")
                return
            }
            
            guard let data else {
                print("DEBUG: Unable to get data from url!")
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        
        urlSessionDataTask.resume()
    }
}

// MARK: - LazyImageView
class LazyImageView: UIImageView {
    
    private let imageCache = NSCache<NSString, UIImage>()
    private let loaderImage = UIImage(named: "loader_image")
    
    func loadImage(from urlString: String) {
        
        self.image = loaderImage
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            print("DEBUG: Used cached image!")
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let urlSessionDataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error {
                print("DEBUG: Error while url session => \(error.localizedDescription)")
                return
            }
            
            guard let data else {
                print("DEBUG: Unable to get data from url!")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                let image = UIImage(data: data) ?? UIImage()
                print("DEBUG: Setting image for cache!")
                self?.imageCache.setObject(image, forKey: urlString as NSString)
                self?.image = image
            }
            
        }
        
        urlSessionDataTask.resume()
    }
    
}
