//
//  ViewReportViewController.swift
//  ReportApp
//
//  Created by LAP15335 on 23/09/2022.
//

import UIKit
import MessageUI

class ViewReportViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var reportDetailList : [Report] = []
    private let viewReportView : ViewReport = ViewReport()
    var detailReportCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        detailReportCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        viewReportView.delegate = self
        viewReportView.initialFisrtLook(viewController: self)
        
        detailReportCollectionView.delegate = self
        detailReportCollectionView.dataSource = self
        detailReportCollectionView.register(DetailReportCell.self, forCellWithReuseIdentifier: "detailReport")
        
        
#if targetEnvironment(macCatalyst)
            //------------right  swipe gestures in collectionView--------------//
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped))
            swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            self.detailReportCollectionView.addGestureRecognizer(swipeRight)

            //-----------left swipe gestures in collectionView--------------//
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(leftSwiped))
            swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
            self.detailReportCollectionView.addGestureRecognizer(swipeLeft)
        
            swipeRight.delegate = self
            swipeLeft.delegate = self
        
            //detailReportCollectionView.isPagingEnabled = true
#endif
        
        Remote.remoteFirebase.readDetailReport(date: self.navigationItem.title!) { loadedData in
            DispatchQueue.main.async {
                self.reportDetailList = loadedData as! [Report]
                //Remove first item ( milestone item)
                if(self.reportDetailList.count > 1){
                    self.reportDetailList.removeFirst()
                    for (index,report) in self.reportDetailList.enumerated() {
                        if(report.userName.caseInsensitiveCompare(UserSession.username) == .orderedSame){
                            self.reportDetailList.swapAt(0, index)
                        }
                    }
                }
                self.detailReportCollectionView.reloadData()
            }
            
        }
    }
    
    private func setupNavBar(){
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
        }
        else{
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
        let vc = EditReportViewController()
        vc.dateOfReport = self.navigationItem.title!
        navigationController?.pushViewController(vc, animated: true)
    }
    
#if targetEnvironment(macCatalyst)
    @objc func rightSwiped(){
        let pageWidth = detailReportCollectionView.frame.width - 10
        let contentOffSet = detailReportCollectionView.contentOffset.x

        if(contentOffSet != 0 ){
            detailReportCollectionView.scrollRectToVisible(CGRect(x: contentOffSet - pageWidth, y: 0, width: detailReportCollectionView.frame.size.width, height:detailReportCollectionView.frame.size.height), animated: true)}
    }
    
    @objc func leftSwiped(){
        let pageWidth = detailReportCollectionView.frame.width - 10
        let contentOffSet = detailReportCollectionView.contentOffset.x
        let contentWidth = detailReportCollectionView.contentSize.width

        if(pageWidth + contentOffSet < contentWidth ){
            detailReportCollectionView.scrollRectToVisible(CGRect(x: pageWidth + contentOffSet, y: 0, width: detailReportCollectionView.frame.size.width, height:detailReportCollectionView.frame.size.height), animated: true)}
    }
#endif
    
}

extension ViewReportViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 20, height: collectionView.frame.size.height - 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension ViewReportViewController : UICollectionViewDelegate{
    
}

extension ViewReportViewController : UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportDetailList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailReport", for: indexPath) as? DetailReportCell{
            let report : Report = reportDetailList[indexPath.row]
            detailCell.configure(tasks: report.tasks,userName: report.userName)
            if(report.userName == "Nothing" && reportDetailList.count != 1){
                detailCell.hidden()
            }
            cell = detailCell
        }
        return cell
    }
    
    
}

extension ViewReportViewController : ViewReportDelegate{
    func sendReport() {
        if(reportDetailList[0].userName == "Nothing"){
            Helper.createAlertOneOption(viewController: self, title: "Information", messages: "Currently there is no task written so it is not possible to send Mail!", completion: nil)
            return
        }
        showMailComposer()
    }
    
}


extension ViewReportViewController : MFMailComposeViewControllerDelegate{
    
    func getCCRecipients() -> [String]{
        var cc: [String] = []
        for report in reportDetailList {
            cc.append(report.userName + "@vng.com.vn")
        }
        cc.append("tuannh2@vng.com.vn")
        return cc
    }
    
    func showMailComposer(){
        guard MFMailComposeViewController.canSendMail() else{
            Helper.createAlertOneOption(viewController: self, title: "Notification", messages: "Your device is not setting email. Please check again!!!", completion: nil)
            return
        }
        
        // format date yyyymmdd
        let splitDate = self.navigationItem.title!.components(separatedBy: "-")
        let dateFormat = splitDate[2] + splitDate[1] + splitDate[0]
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["cuongvt2@vng.com.vn"])
        composer.setCcRecipients(getCCRecipients())
        composer.setSubject("Daily report - Zing MP3 iOS - \(dateFormat)")
        composer.setMessageBody(generateHTMLTableReport(), isHTML: true)
        present(composer,animated: true)
    }
    
    func generateHTMLTableReport() -> String{
        return """
                <style>
                  .report {
                    border-collapse: collapse;
                    margin: 25px 0;
                    font-size: 0.9em;
                    font-family: sans-serif;
                    min-width: 400px;
                    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
                }
                  .report thead tr {
                    background-color: #72179A;
                    color: #ffffff;
                    text-align: left;
                }
                  .report th,
                .report td {
                    padding: 12px 15px;
                }
                  .report tbody tr {
                    border-bottom: 1px solid #dddddd;
                }
                
                .report tbody tr:nth-of-type(even) {
                    background-color: #f3f3f3;
                }
                
                  .report tbody tr.active-row {
                    font-weight: bold;
                    color: #009879;
                }
                
                </style>
                <p>Team Dev IOS Zing MP3 xin g???i t???i anh report ng??y \(self.navigationItem.title!) nh?? sau:</p>
                
                
                <table class="report">
                <thead>
                    <tr>
                        <th></th>
                        <th>Task</th>
                        <th>Status</th>
                        <th>Note</th>
                    </tr>
                </thead>
                <tbody>
                    \(generateHTMLUserReport())
                </tbody>
                </table>
                <p> Best regards,</p>
                <p> \(UserSession.username) </p>
                """
    }
    
    func generateHTMLUserReport() -> String{
        var result: String = ""
        for report in reportDetailList{
            if(report.userName == "Nothing"){
                continue}
            result.append("""
                        <tr>
                          <td rowspan=\(report.tasks.count)>\(report.userName)</td>
                            \(generateHTMLUserTask(tasks: report.tasks))
                        """)
            
        }
        return result
    }
    
    func generateHTMLUserTask(tasks: [Task]) -> String{
        var result: String = ""
        for (index,task) in tasks.enumerated(){
            if(index != 0){
                result.append("""
                              <tr>
                                <td>[\(task.title)] \(task.detail)</td>
                                <td><strong>\(task.status)%</strong></td>
                                <td><p style="color:red">\(task.note)</p></td>
                              </tr>
                              """)
            }
            else{
                result.append("""
                          
                            <td>[\(task.title)] \(task.detail)</td>
                            <td><strong>\(task.status)%</strong></td>
                            <td><p style="color:red">\(task.note)</p></td>
                          </tr>
                          """)
                
            }
            
        }
        return result
    }
    
    
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error{
            //Show error alert
            controller.dismiss(animated: true)
            return
        }
        
        switch result{
        case .cancelled:
            print("Mail cancelled")
        case .failed:
            print("Mail fail")
        case .saved:
            print("Mail saved")
        case .sent:
            let currentDateTime = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.dateStyle = .none
            
            Remote.remoteFirebase.updateStatusReport(status: "Sent by \(UserSession.username) at \(formatter.string(from: currentDateTime))", date: self.navigationItem.title!)
            
        @unknown default:
            fatalError("result mail error")
        }
        
        controller.dismiss(animated: true)
        return
    }
}
