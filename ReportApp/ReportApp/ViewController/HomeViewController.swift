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
        
        homeView.delegate = self
        homeView.initialFisrtLook(viewController : self)
    
        
        reportCollectionView.delegate = self
        reportCollectionView.dataSource = self
        
        
        reportCollectionView.register(ReportCell.self, forCellWithReuseIdentifier: "report")
        
        
        Remote.remoteFirebase.readAllReport { loadedData in
            DispatchQueue.main.async {
                self.reportlist = loadedData as! [Report]
                self.reportCollectionView.reloadData()
            }
            
        }
      
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

extension HomeViewController : HomeViewDelegate{
    func createReport() {
        // create the alert
        let alert = UIAlertController(title: "Information", message: "Would you like to generate a report for today?", preferredStyle: UIAlertController.Style.alert)

        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default,handler: {_ in
            let mytime = Date()
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yyyy"
            
            for report in self.reportlist{
                if(report.date == format.string(from: mytime)){
                    // create the alert
                    let alert = UIAlertController(title: "Notification", message: "Today's report was created earlier.", preferredStyle: UIAlertController.Style.alert)
                    
                
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                    
                 
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }
            }
            Remote.remoteFirebase.createReport(date: format.string(from: mytime))
        }))
                        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
                        
      
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
