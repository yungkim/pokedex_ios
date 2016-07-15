//
//  PokedexTableViewController.swift
//  pokedex
//
//  Created by Yung Kim on 7/15/16.
//  Copyright © 2016 Yung Kim. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController, DetailsViewControllerDelegate {
    

    @IBOutlet weak var button: UIButton!
    var pokemons: [Pokemon] = []
    var index: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people
        return pokemons.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Create a generic cell
//        let cell = UITableViewCell()
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PokemonCell") as! PokemonCell
        cell.indexNumberLabel.text = "\(indexPath.row+1)"
        cell.indexNumberLabel.tag = indexPath.row+1
        
        cell.nameLabel?.text = pokemons[indexPath.row].name
        
//        print(pokemons[indexPath.row].name)
        // return the cell so that it can be rendered
        return cell
    }
    
    func getPokemonData() {
        let url = NSURL(string: "https://pokeapi.co/api/v2/pokemon/?limit=151")
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
//                print(jsonResult)
               print(jsonResult["results"])
                let arr = jsonResult["results"] as! NSArray
                for element in arr {
                    let dictionary = element as! NSDictionary
                    let pokemon = Pokemon(dictionary: dictionary)
//                    print(pokemon)
//                    print(pokemon.name)
                    
                    self.pokemons.append(pokemon)
                }
                self.tableView.reloadData()
                
                    
                    
//                    if let results = jsonResult["results"] {
//                        // coercing the results object as an NSArray and then storing that in resultsArray
//                        let resultsArray = results as! NSArray
//
//                        // now we can run NSArray methods like count and firstObject
//                        print(resultsArray.count)
//                        print(resultsArray.firstObject)
//                        for i in 1...resultsArray.count {
//                            let pokemon = resultsArray[i-1].valueForKey("name")!
//                            self.pokemons.append(pokemon as! String)
//                            self.tableView.reloadData()
//                        }
//                        dispatch_async(dispatch_get_main_queue(), {
//                            self.tableView.reloadData()
//                        })
//                    }
//                }
                    
                    
                    
                    
                    
            } catch {
                print("Something went wrong")
            }
        })
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        index = indexPath.row+1
//        print(indexPath)
        print(indexPath.row+1)
        index = indexPath.row+1
        
        performSegueWithIdentifier("toPokeViewSegue", sender: index)
    }

    @IBAction func detailsButtonPressed(sender: UIButton) {
        print(sender)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

  
            let destination = segue.destinationViewController as! DetailsViewController
            print("index from prepare segue \(sender)")
        
            destination.index = sender as! Int
//            destination.delegate = self
        
    }
    func passIndex(count: Int) {
 
        
    }
    
}

