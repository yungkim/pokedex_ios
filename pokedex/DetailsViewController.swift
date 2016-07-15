//
//  ViewController.swift
//  pokedex
//
//  Created by Yung Kim on 7/15/16.
//  Copyright © 2016 Yung Kim. All rights reserved.
//

import UIKit

protocol DetailsViewControllerDelegate
{
    func passIndex(count: Int)
}

class DetailsViewController: UIViewController {
    @IBOutlet weak var statsLabel: UILabel!

    @IBOutlet weak var pokemonImage: UIImageView!
    var arr: [String] = []
    var index: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(DetailsViewController.back))
        navigationItem.setRightBarButtonItem(btn, animated: false)
        
        navigationItem.hidesBackButton = true
        print("index \(index)")
        getPokemonData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func back() {
        print("going back...")
//        delegate?.saveCount(count)
        navigationController?.popViewControllerAnimated(true)
    }

    
    
    
    func getPokemonData() {
        let makeURL = "http://pokeapi.co/api/v2/pokemon/" + String(index!)
        let url = NSURL(string: makeURL)
        // Create an NSURLSession to handle the request tasks
        let session = NSURLSession.sharedSession()
        // Create a "data task" which will request some data from a URL and then run a completion handler after it is done
        let task = session.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            // We get data, response, and error back. Data contains the JSON data, Response contains the headers and other information about the response, and Error contains an error if one occured
            // A "Do-Try-Catch" block involves a try statement with some catch block for catching any errors thrown by the try statement.
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
//                                print(jsonResult)
//                print(jsonResult["results"])
                let arr = jsonResult as! NSDictionary
                print(arr.valueForKey("sprites")?.valueForKey("front_default")!)
                print(arr.valueForKey("stats"))
//                self.statsLabel.text = String(arr.valueForKey("stats"))
//                let pokemon = Sprites(dictionary: dictionary)
               
                var image_data: NSData?
                let makeImageURL = arr.valueForKey("sprites")?.valueForKey("front_default")
                let image_url = NSURL(string:makeImageURL! as! String)
                image_data = NSData(contentsOfURL:image_url!)
                if image_data != nil {
                    self.pokemonImage.image = UIImage(data:image_data!)
                }

                
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.statsLabel.text = String(arr.valueForKey("forms")!.firstObject!!.name)
                
                
               
                

                
                
                
            } catch {
                print("Something went wrong")
            }
        })
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()

    }

    
    
    
}
