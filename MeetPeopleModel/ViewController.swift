//
//  ViewController.swift
//  MeetPeopleModel
//
//  Created by Anh Hao on 12/13/17.
//  Copyright © 2017 Anh Hao. All rights reserved.
//
import Foundation
import UIKit
var cache = NSCache<AnyObject, AnyObject>()
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var name = [String]()
    var imageArray = [String]()
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PeopleCollectionViewCell
        configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .data, object: nil)
    }
    func configureCell(_ cell: PeopleCollectionViewCell, indexPath: IndexPath) {
        DataServices.shared.getURl(imageID: imageArray[indexPath.row])
        cell.nameLabel.text = name[indexPath.row]
        
        DispatchQueue.main.async {
            self.downloadImage(cell, indexPath: indexPath)
        }
        
    }
    func downloadImage(_ cell: PeopleCollectionViewCell, indexPath: IndexPath) {
        if let imageURL = URL(string: DataServices.shared.urlArray[indexPath.row]) {
            let url = imageURL
            if let imageFromCache = cache.object(forKey: url as AnyObject) as? UIImage {
                cell.userImage.image = imageFromCache
                return
            }
            if DataServices.shared.urlArray[indexPath.row] != "" {
                guard let imageData = try? Data(contentsOf: imageURL) else {return}
                if let imageFromCache = UIImage(data: imageData) {
                    cell.userImage.image = imageFromCache
                    cache.setObject(imageFromCache, forKey: url as AnyObject)
            }
        }
    }
    }
    
    func reloadData() {
        self.name.append(DataServices.shared.name)
        self.imageArray.append(DataServices.shared.imageURL)
        DispatchQueue.main.async {
            self.collectionVIew.reloadData()
        }
    }
    deinit {
        DataServices.shared.urlArray.removeAll()
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



