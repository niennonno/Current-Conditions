//
//  ViewController.swift
//  Current Conditions
//
//  Created by Aditya Vikram Godawat on 08/01/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cityTextField: UITextField!

    var wasSuccessful = false
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") +  "/forecasts/latest")
        
        if let url = attemptedUrl{
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data{
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                let websiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray?.count > 1 {
                    let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                   
                    if weatherArray.count > 1 {
                        
                        self.wasSuccessful = true
                        let weatherSummary = weatherArray[0]
                  .stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.resultLabel.text = weatherSummary
                    })
                    
                    }
                }
                
                if self.wasSuccessful == false {
                self.resultLabel.text = "Sorry! The city does not exist!"
                }
            }else{
                print("Error")
            }
            
        }
        
        task.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

