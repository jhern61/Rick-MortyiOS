//
//  ViewController.swift
//  R&M Wiki
//
//  Created by Joe Hernandez on 1/7/19.
//  Copyright © 2019 Joe Hernandez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageHolder: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var lastLocationLabel: UILabel!
    var pageNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      getInformation(pageNumber: 1)
    }
    
    
    @IBAction func BackOrNextButton(_ sender: UIButton) {
        if(sender.currentTitle=="Previous"){
            pageNumber = pageNumber - 1
        } else if(sender.currentTitle=="Next"){
            pageNumber = pageNumber + 1
        }
        
        getInformation(pageNumber: pageNumber)
    }
    
    
    
    
    func getInformation(pageNumber: Int) {
        let baseURL = "https://rickandmortyapi.com/api/character/\(pageNumber)"
        AF.request(baseURL, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let rickAndMortyAPI : JSON = JSON(response.result.value!)
                print(rickAndMortyAPI)
                self.updateInformation(json: rickAndMortyAPI)
            }
            else {
                //print("Error \(String(describing: response.result.error))")
               // self.cityLabel.text = "Connection Issues"
            }
        }
        
        
        
        
        
        
    }//end getInformation Method
    
    func updateInformation(json : JSON) {
        
       // let tempResult = json["name"]["temp"].doubleValue
        let name = json["name"].string
        let gender = json["gender"].string
        let status = json["status"].string
        let profileImage = json["image"].string!
        let origin = json["origin"]["name"].string
        let lastLocation = json["location"]["name"].string
        let species = json["species"].string
        
        //print(name)
       
        nameLabel.text = name
        speciesLabel.text = species
        genderLabel.text = gender
        statusLabel.text = status
        originLabel.text = origin
        lastLocationLabel.text = lastLocation
      
        //Use image from URL
        let photoURL = URL(string: profileImage)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: photoURL!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
               self.profileImageHolder.image = UIImage(data: data!)
            }
        }
      
//        updateUIWithWeatherData()
    }
    
    
    
}




