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
        homeView.delegate = self
        reportCollectionView.showsVerticalScrollIndicator = false
        reportCollectionView.delegate = self
        reportCollectionView.dataSource = self
        reportCollectionView.register(ReportCell.self, forCellWithReuseIdentifier: "report")
        
        //Read data report date from database
        Remote.remoteFirebase.readAllReport { loadedData in
            DispatchQueue.global().async {
                self.reportlist = loadedData as! [Report]
                self.reportlist = self.reportlist.sorted(by: {Helper.getDate(dateString: $0.date)!  > Helper.getDate(dateString: $1.date)!})
                
                DispatchQueue.main.async {
                    self.reportCollectionView.reloadData()
                }
            }
            
            
        }
      
    }
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //View Detail Report
        let vc = ViewReportViewController()
        vc.navigationItem.title = (reportlist[indexPath.row]).date
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let reportCell = collectionView.dequeueReusableCell(withReuseIdentifier: "report", for: indexPath) as? ReportCell{
            
            let report : Report = reportlist[indexPath.row]
            
            reportCell.config(report: report)
            
            cell = reportCell
            
        }
        
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height:collectionView.frame.size.height / 8 )
    }
}

extension HomeViewController : HomeViewDelegate{
    func logOut() {
        let alert = UIAlertController(title: "Information", message: "Do you want to logout?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default,handler: {_ in
            UserDefaults.standard.removeObject(forKey: "user")
            let vc = ViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func createReport() {
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
                    
                    // show the alert
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
