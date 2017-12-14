//
//  ViewController.swift
//  MeetPeopleModel
//
//  Created by Anh Hao on 12/13/17.
//  Copyright © 2017 Anh Hao. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var name = [String]()
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PeopleCollectionViewCell
        cell.nameLabel.text = name[indexPath.row]
        return cell
    }
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .data, object: nil)
    }
    func reloadData() {
        self.name.append(DataServices.shared.name)
        print(name.count)
        DispatchQueue.main.async {
            self.collectionVIew.reloadData()
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DataServices.shared.getData()
        registerNotification()
        collectionVIew.delegate = self
        collectionVIew.dataSource = self
        isChange = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    var isChange: Bool = true {
        didSet {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = isChange ? CGSize(width: 300, height: 80) : CGSize(width: 80, height: 80)
            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
            layout.minimumLineSpacing = 1.0
            layout.minimumInteritemSpacing = 1.0
            layout.scrollDirection = isChange ? .vertical : .horizontal
            collectionVIew.setCollectionViewLayout(layout, animated: false)
            collectionVIew.reloadData()
        }
    }

    @IBAction func changeTypeClV(_ sender: Any) {
        if let layout = collectionVIew.collectionViewLayout as? UICollectionViewFlowLayout {
            if layout.scrollDirection == .vertical {
                layout.scrollDirection = .horizontal
                isChange = false
            } else {
                layout.scrollDirection = .vertical
                isChange = true
              collectionVIew.scrollToItem(at: IndexPath(row: 1, section: 0), at: UICollectionViewScrollPosition.top, animated: false)
            }
        }
    }
}



