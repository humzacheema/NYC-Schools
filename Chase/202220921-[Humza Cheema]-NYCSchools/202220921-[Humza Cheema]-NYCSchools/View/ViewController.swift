//
//  ViewController.swift
//  202220921-[Humza Cheema]-NYCSchools
//
//  Created by Humza Cheema on 9/21/22.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var nameOfSchools:[String] = []
    var mathScore:[String] = []
    var readingScore:[String] = []
    var writingScore:[String] = []
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        requestURL()
        requestUrl()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameOfSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as!
        UserTableViewCell
        cell.listOfSchools.text = nameOfSchools[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectCell = nameOfSchools[indexPath.row]
        let detailVc = storyboard?.instantiateViewController(withIdentifier: "SchoolViewController") as! SchoolViewController
        if selectCell == nameOfSchools[indexPath.row]{
            detailVc.writeScore = "Writing Score: \(writingScore[indexPath.row])"
            detailVc.readScore = "Reading Score: \(readingScore[indexPath.row])"
            detailVc.mthScore = "Math Score: \(mathScore[indexPath.row])"
            navigationController?.pushViewController(detailVc, animated: true)
        }
    }
    
    func requestURL(){
        guard let url = URL(string:"https://data.cityofnewyork.us/resource/s3k6-pzi2.json") else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else{return}
            do{
                let decodeData = try JSONDecoder().decode([SchoolName].self, from: data)
                for i in decodeData{
                    DispatchQueue.main.async {
                        self.nameOfSchools.append("\(i.school_name)")
                        self.tableview.reloadData()
                    }
                }
            }catch{
                print(error)
            }
        }
        .resume()
    }
    
    func requestUrl(){
        guard let url = URL(string:"https://data.cityofnewyork.us/resource/f9bf-2cp4.json") else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let decodedData = try JSONDecoder().decode([SchoolDetail].self, from: data)
                for x in decodedData{
                    DispatchQueue.main.async {
                        self.mathScore.append("\(x.sat_math_avg_score)")
                        self.readingScore.append("\(x.sat_critical_reading_avg_score)")
                        self.writingScore.append("\(x.sat_writing_avg_score)")
                    }
                }
                
            }catch{
                print(error)
            }
        }
        .resume()
    }
}




