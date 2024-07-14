//
//  MyViewController.swift
//  SAA-App
//
//  Created by SAHIL AGASHE on 05/07/24.
//

import UIKit
import SwiftUI

struct Info: Decodable {
    let text1: String
    let text2: String
}

let mockJsonString = """
[
  {
    "text1": "Hi Sahil, I am from Mock JSON String 0",
    "text2": "Believe in yourself! Everything is possible!!! 0"
  },
  {
    "text1": "Hi Sahil, I am from Mock JSON String 1",
    "text2": "Believe in yourself! Everything is possible!!! 5"
  },
  {
    "text1": "Hi Sahil, I am from Mock JSON String 2",
    "text2": "Believe in yourself! Everything is possible!!! 10"
  },
  {
    "text1": "Hi Sahil, I am from Mock JSON String 3",
    "text2": "Believe in yourself! Everything is possible!! 15"
  },
  {
    "text1": "Hi Sahil, I am from Mock JSON String 4",
    "text2": "Believe in yourself! Everything is possible!! 20!"
  },
  {
    "text1": "Hi Sahil, I am from Mock JSON String 5",
    "text2": "Believe in yourself! Everything is possible!!! 25"
  },
  {
    "text1": "Hi Sahil, I am from Mock JSON String 6",
    "text2": "Believe in yourself! Everything is possible!!! 30"
  },
  {
    "text1": "Hi Sahil, I am from Mock JSON String 7",
    "text2": "Believe in yourself! Everything is possible!!! 35"
  },
  {
    "text1": "Hi Sahil, I am from Mock JSON String 8",
    "text2": "Believe in yourself! Everything is possible!!! 40"
  },
  {
    "text1": "Hi Sahil, I am from Mock JSON String 9",
    "text2": "Believe in yourself! Everything is possible!!! 45"
  },
  {
    "text1": "Hi Sahil, I am from Mock JSON String 10",
    "text2": "Believe in yourself! Everything is possible!!! 50"
  },
  {
    "text1": "Hi Sahil, I am from Mock JSON String 11",
    "text2": "Believe in yourself! Everything is possible!!! 55"
  }
]
"""

let jsonData = mockJsonString.data(using: .utf8)!

let myInfos = try! JSONDecoder().decode([Info].self, from: jsonData)


class MyViewController: UIViewController {
    
    static let tableCellIdentifier = "Cell"
    
    private lazy var myTable: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: MyViewController.tableCellIdentifier)
        return tv
    }()
    
    private var dataArray = [Info]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(myTable)
        print(myInfos)
        
        NSLayoutConstraint.activate([
            myTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            myTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            myTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        myTable.reloadData()
    }
}

extension MyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyViewController.tableCellIdentifier) else {
            return UITableViewCell()
        }
        
        let info = myInfos[indexPath.row]
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = info.text1
        contentConfig.secondaryText = info.text2
        cell.contentConfiguration = contentConfig
        
        return cell
    }
    
    
}

extension MyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Show Details Of Row At IndexPath => \(indexPath)")
        let info = myInfos[indexPath.row]
        let vc = DetailsViewController()
        vc.setData(textInput: info.text1, and: info.text2)
        show(vc, sender: self)
    }
}

struct MyViewControllerScreen: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {}
    
    func makeUIViewController(context: Context) -> MyViewController {
        MyViewController()
    }
}

#Preview {
    MyViewControllerScreen()
}
