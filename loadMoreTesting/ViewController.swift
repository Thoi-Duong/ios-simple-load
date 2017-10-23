//
//  ViewController.swift
//  loadMoreTesting
//
//  Created by thoiduong on 10/23/17.
//  Copyright © 2017 thoiduong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var DataSourecs: [String] = []
    
    var currentIndex: IndexPath =  IndexPath.init(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tableView.leftAnchor.constraint(equalTo: view.leftAnchor)])

        setUpdateData()
        
        currentIndex = IndexPath.init(row: DataSourecs.count - 1, section: 0)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpdateData(){
        for i in 1...100{
            DataSourecs.append(i.description)
        }
    }
    
    func loadMore(){
        DataSourecs.reverse()
        for i in DataSourecs{
            DataSourecs.append("loadMode + \(i)")
        }
        DataSourecs.reverse()
        tableView.reloadData()
        tableView.scrollToRow(at: currentIndex, at: .top, animated: false)
        
        currentIndex = IndexPath.init(row: DataSourecs.count - 1, section: 0)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSourecs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = DataSourecs[indexPath.row]
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0{
            loadMore()
        }
    }
    
}

