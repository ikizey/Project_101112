//
//  DetailViewController.swift
//  Project_101112
//
//  Created by PrincePhoenix on 09.06.2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var ImageView: UIImageView!
    
    var image: UIImage!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ImageView.image = image
        title = name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
