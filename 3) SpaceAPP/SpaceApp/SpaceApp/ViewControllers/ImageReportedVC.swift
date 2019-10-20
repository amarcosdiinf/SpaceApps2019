//
//  ImageReportedVC.swift
//  SpaceApp
//
//  Created by Administrador on 19/10/2019.
//  Copyright © 2019 valde. All rights reserved.
//

import UIKit

class ImageReportedVC: UIViewController {

    var imgAux = UIImage()
    
    @IBOutlet weak var fireTypeOut: UISegmentedControl!
    
    @IBOutlet weak var fireCauseOut: UISegmentedControl!
    @IBOutlet weak var imgReported: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        imgReported.image = imgAux
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendInfo(_ sender: Any) {
        let fireType = fireTypeOut.titleForSegment(at: fireTypeOut.selectedSegmentIndex)
        let fireCause = fireCauseOut.titleForSegment(at: fireCauseOut.selectedSegmentIndex)
        
        let alert = UIAlertController(title: "Sent", message: "Your report has been sent", preferredStyle: .alert)
        let okay = UIAlertAction(title: "OK", style: .default) { (action) in
            self.performSegue(withIdentifier: "reportSent", sender: nil)
        }
        
        alert.addAction(okay)
        present(alert, animated : true, completion: nil)
    }
    

}
