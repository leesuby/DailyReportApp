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
        
        //Hidden navigation
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
                //Save data and sort descending date
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
            let report : Report = reportlist[indexPath.item]
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
        Helper.createAlertTwoOption(viewController: self, title: "Information", messages: "Do you want to logout?", yes: { _ in
            UserDefaults.standard.removeObject(forKey: "user")
            let vc = ViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, no: nil)
        
    }
    
    func createReport() {
        Helper.createAlertTwoOption(viewController: self, title: "Information", messages: "Would you like to generate a report for today?", yes: { _ in
            let mytime = Date()
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yyyy"
            for report in self.reportlist{
                if(report.date == format.string(from: mytime)){
                    Helper.createAlertOneOption(viewController: self, title: "Notification", messages: "Today's report was created earlier", completion: nil)
                }
            }
            Remote.remoteFirebase.createReport(date: format.string(from: mytime))
        }, no: nil)
    }
}
