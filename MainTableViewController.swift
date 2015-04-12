//
//  MainTableViewController.swift
//  ChatterApp2.0
//
//  Created by David Carter on 3/26/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class MainTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
        @IBOutlet weak var tableView: UITableView!
        
        var audioPlayer = AVAudioPlayer()
        
        var chatterFiles: [ChatterFile] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Roll Tide...
            self.tableView.dataSource = self
            self.tableView.delegate = self
            
        }
        
        override func viewWillAppear(animated: Bool) {
            super.viewWillAppear(animated)
            // Roll Tide...
            var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
            var request = NSFetchRequest(entityName: "ChatterFile")
            self.chatterFiles = context.executeFetchRequest(request, error: nil)! as! [ChatterFile]
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.chatterFiles.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var chatterfile = self.chatterFiles[indexPath.row]
            var cell = UITableViewCell()
            cell.textLabel!.text = chatterfile.name
            return cell
        }
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            var chatterfile = self.chatterFiles[indexPath.row]
            
            var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
            var pathComponents = [baseString, chatterfile.url]
            var audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)
            
            self.audioPlayer = AVAudioPlayer(contentsOfURL: audioNSURL, error: nil)
            self.audioPlayer.play()
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            var nextViewControler = segue.destinationViewController as! ChatterFileViewController
            nextViewControler.previousViewController = self
        }
        
    }

