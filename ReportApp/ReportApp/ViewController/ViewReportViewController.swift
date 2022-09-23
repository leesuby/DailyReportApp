//
//  ViewReportViewController.swift
//  ReportApp
//
//  Created by LAP15335 on 23/09/2022.
//

import UIKit

class ViewReportViewController: UIViewController {
    
    private let viewReportView : ViewReport = ViewReport()
    var detailReportCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        detailReportCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        viewReportView.initialFisrtLook(viewController: self)
        
        detailReportCollectionView.delegate = self
        detailReportCollectionView.dataSource = self
        
        detailReportCollectionView.register(DetailReportCell.self, forCellWithReuseIdentifier: "detailReport")
        // Do any additional setup after loading the view.
    }
    
    
    
    private func setupNavBar(){
        navigationItem.title = "19/09/2022"
        self.navigationController!.navigationBar.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editReport))
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            
            appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.latoBold(size: 24)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.configureWithOpaqueBackground()
            appearance.backgroundImage = UIImage(named: "BannerHome")
    
            appearance.shadowColor = .white
            appearance.shadowImage = UIImage()
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }else{
            
            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.latoBold(size: 24)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            
            self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "BannerHome"), for: .default)
            self.navigationController!.navigationBar.shadowImage = UIImage()
            self.navigationController!.navigationBar.isTranslucent = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @objc func editReport(){
        
    }
    
}

extension ViewReportViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:  400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
}

extension ViewReportViewController : UICollectionViewDelegate{
    
}

extension ViewReportViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailReport", for: indexPath) as? DetailReportCell{
            
            cell = detailCell
        }
        
        return cell
    }
    
    
}
