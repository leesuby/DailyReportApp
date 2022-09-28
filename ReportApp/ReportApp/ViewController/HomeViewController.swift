//
//  HomeViewController.swift
//  ReportApp
//
//  Created by LAP15335 on 22/09/2022.
//

import Foundation
import UIKit

class HomeViewController: UIViewController{
    
    private var reportlist : [Report] = []
    
    private let homeView = HomeView()
    var reportCollectionView : UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        homeView.initialFisrtLook(viewController : self)
    
        
        reportCollectionView.delegate = self
        reportCollectionView.dataSource = self
        
        
        reportCollectionView.register(ReportCell.self, forCellWithReuseIdentifier: "report")
        
        
        Remote.remoteFirebase.readAllReport { loadedData in
            DispatchQueue.main.async {
                self.reportlist = loadedData as! [Report]
                print(self.reportlist)
                self.reportCollectionView.reloadData()
            }
            
        }
      
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeView.initialLayer(view: view)
        
    }
    
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ViewReportViewController()
        vc.navigationItem.title = (reportlist[indexPath.row]).date

        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let reportCell = collectionView.dequeueReusableCell(withReuseIdentifier: "report", for: indexPath) as? ReportCell{
            
            let report : Report = reportlist[indexPath.row]
            
            reportCell.config(date: report.date)
            
            cell = reportCell
            
        }
        
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:collectionView.frame.size.height / 4 )
    }
}
