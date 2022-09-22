//
//  HomeViewController.swift
//  ReportApp
//
//  Created by LAP15335 on 22/09/2022.
//

import Foundation
import UIKit

class HomeViewController: UIViewController{
    
    private let homeView = HomeView()
    var reportCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        homeView.initialFisrtLook(viewController : self)
    
        
        reportCollectionView.delegate = self
        reportCollectionView.dataSource = self
        
        
        reportCollectionView.register(ReportCell.self, forCellWithReuseIdentifier: "report")
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeView.initialLayer(view: view)
    }
    
}

extension HomeViewController: UICollectionViewDelegate{
    
}

extension HomeViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        print("asdas")
        if let reportCell = collectionView.dequeueReusableCell(withReuseIdentifier: "report", for: indexPath) as? ReportCell{
            
            cell = reportCell
            
        }
        
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:collectionView.frame.size.height / 2 )
    }
}
