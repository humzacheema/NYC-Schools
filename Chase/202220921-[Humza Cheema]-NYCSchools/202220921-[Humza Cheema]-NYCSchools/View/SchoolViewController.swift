//
//  SchoolViewController.swift
//  202220921-[Humza Cheema]-NYCSchools
//
//  Created by Humza Cheema on 9/21/22.
//

import UIKit

class SchoolViewController: UIViewController {
    
    var mthScore:String?
    var writeScore:String?
    var readScore:String?
    
    @IBOutlet weak var matchScore: UILabel!
    @IBOutlet weak var readingScore: UILabel!
    @IBOutlet weak var writingScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchScore.text = mthScore
        writingScore.text = writeScore
        readingScore.text = readScore
    }
}
