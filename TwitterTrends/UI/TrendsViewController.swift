//
//  ViewController.swift
//  TwitterTrends
//
//  Created by Agnieszka Bugajewski on 23.01.18.
//  Copyright © 2018 Agnieszka Bugajewski. All rights reserved.
//

import UIKit
import SafariServices

/** Simple table view controller just for demo purposes. */
class TrendsViewController: UITableViewController {
    
    /**
     All API communication is done by this class.
     */
    let api: API = TwitterAPI()
    
    /**
     Trends from Twitter API that get displayed in table view.
     */
    var trends: [TrendingTopic.Trend]? {
        didSet {
            // Update table view on main thread after trends got successfully fetched.
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Encode key & secret according to Twitter documentation.
        guard let encodedKey = Config.API.Auth.consumerKey.rawValue.addingPercentEncoding(withAllowedCharacters:.urlFragmentAllowed),
            let encodedSecret = Config.API.Auth.consumerSecret.rawValue.addingPercentEncoding(withAllowedCharacters:.urlFragmentAllowed) else {
                return
        }
        
        let authString = encodedKey + ":" + encodedSecret
        let authData = Data(authString.utf8)
        let encodedAuthString = authData.base64EncodedString()
        
        // Try to authenticate.
        api.fetchBearerToken(authString: encodedAuthString) { (token, error) in
            if error != nil {
                self.presentAlert(title: NSLocalizedString("Auth Error", comment: "Error message on authentication failure."), message: error!.localizedDescription)
            }
            
            // Fetch trends after successful authentication.
            self.api.fetchTrends(bearerToken: token, completion: { (trends, error) in
                if error != nil {
                    self.presentAlert(title: NSLocalizedString("API Error", comment: "Error message during API communication."), message: error!.localizedDescription)
                }
                
                self.trends = trends
            })
        }
    }
    
    /**
     Present a generic alert after an API error occurred.
     
     - parameters:
        - title: The alert title.
        - message: The alert message.
     */
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`))
        
        // Make sure to update UI on main thread.
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trends?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendCell", for: indexPath)
        
        let trend = trends?[indexPath.row]
        
        cell.textLabel!.text = trend?.name
        
        return cell
    }
    
    /**
     Open the selected trending topic in a Safari View Controller.
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let trend = trends?[indexPath.row] else {
            return
        }
        
        let safariViewController = SFSafariViewController(url: trend.url)
        present(safariViewController, animated: true)
    }
}

