//
//  ViewController.swift
//  WeatherApp
//
//  Created by Zhe Chen on 7/23/17.
//  Copyright © 2017 Zhe Chen. All rights reserved.
// samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=1257ff5e85b94720399d4e5a90c55965
// Application

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var baseURL = "http://samples.openweathermap.org/data/2.5/weather?q="
    var location = ""
    var getAPI = "&appid="
    var api = "1257ff5e85b94720399d4e5a90c55965"
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getWeather: UIButton!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    var temperature = 0.0
    var weatherT = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func getWeatherTapped(_ sender: Any) {
        
        
        let runningURL = "\(baseURL)\(cityTextField.text!.replacingOccurrences(of: " ", with: ""))\(getAPI)\(api)"
        
        Alamofire.request(runningURL).responseJSON { (response) in
            print(response)
            
            let result = response.result
            
            //Get Data and update labels
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let webTemp = main["temp"] as? Double {
                        self.temperature = webTemp - 273.15
                        print(self.temperature)
                        self.temp.text = "Temperature is \(self.temperature)°"
                    }
                }
            }
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let webWeather = dict["weather"]![0] as? Dictionary<String, AnyObject> {
                    if let webMain = webWeather["main"] as? String {
                        self.weatherT = webMain
                        print(self.weatherT)
                        self.weatherType.text = "Weather is: \(self.weatherT)"
                    }
                }
            }
            
            
        }
        
        
    }
    @IBAction func textFieldChanged(_ sender: Any) {
        
        if (cityTextField.text?.characters.count)! > 0 {
        getWeather.isEnabled = true
    }
        else {
            getWeather.isEnabled = false
        }

}

}
