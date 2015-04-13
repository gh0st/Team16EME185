//
//  ChatterFileViewController.swift
//  ChatterApp2.0
//
//  Created by David Carter on 3/26/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ChatterFileViewController : UIViewController {
    
    required init(coder aDecoder: NSCoder) {
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        self.audioURL = NSUUID().UUIDString + ".m4a"
        var pathComponents = [baseString, self.audioURL]
        var audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings: [NSObject : AnyObject] = Dictionary()
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        recordSettings[AVSampleRateKey] = 44100.0
        recordSettings[AVNumberOfChannelsKey] = 2
        
        self.audioRecorder = AVAudioRecorder(URL: audioNSURL, settings: recordSettings, error: nil)
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord()
        
        // super init below
        super.init(coder: aDecoder)
    }
    
    
    @IBOutlet weak var chatterTextField: UITextField! // chatter file name text field
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder
    var audioURL: String
    var previousViewController = MainTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // LGI
    }
    // cancel button
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // save button
    @IBAction func saveTapped(sender: AnyObject) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        // create a chatterfile object
        var chatterfile = NSEntityDescription.insertNewObjectForEntityForName("ChatterFile", inManagedObjectContext: context) as! ChatterFile
        chatterfile.name = chatterTextField.text
        chatterfile.url = self.audioURL
        
        // save sound to core data
        context.save(nil)
        
        // dismiss this view controller
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // record button
    @IBAction func recordTapped(sender: AnyObject) {
        if self.audioRecorder.recording { // if recording
            self.audioRecorder.stop()
            self.recordButton.setTitle("RECORD", forState: UIControlState.Normal)
        }else{ // if not recording
            var session = AVAudioSession.sharedInstance()
            session.setActive(true, error: nil)
            self.audioRecorder.record()
            self.recordButton.setTitle("Stop Recording", forState: UIControlState.Normal)
        }
        
    }
    
}

/* Version with keyboard control stuff that won't run //
//  ChatterFileViewController.swift
//  ChatterApp2.0
//
//  Created by David Carter on 3/26/15.
//  Copyright (c) 2015 Team16. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ChatterFileViewController : UIViewController {
    
    

    required init(coder aDecoder: NSCoder) {
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        self.audioURL = NSUUID().UUIDString + ".m4a"
        var pathComponents = [baseString, self.audioURL]
        var audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings: [NSObject : AnyObject] = Dictionary()
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        recordSettings[AVSampleRateKey] = 44100.0
        recordSettings[AVNumberOfChannelsKey] = 2
        
        self.audioRecorder = AVAudioRecorder(URL: audioNSURL, settings: recordSettings, error: nil)
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord()
        
        // super init below
        super.init(coder: aDecoder)
    }
    
    
    @IBOutlet weak var chatterTextField: UITextField! // chatter file name text field
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder
    var audioURL: String
    var previousViewController = MainTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // LGI
        
/* //// Keyboard stuff that was working but now it isn't ///

    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);

    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 200
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 200
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
        super.touchesBegan(touches as Set<NSObject>, withEvent: event)
    }
    

*/
    
    // var instanceOfKeyboard: keyboard = keyboard()
    
    
    
    
    
    /* func keyboardWasShown(notification: NSNotifcation) {
        var info = notication.userInfo!
        var keyboardFrame: CGRect = (info[UIKeboardFrameEndUserInfoKey] as NSValue).CGRectValue
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomContraint.constant = keboardFrame.size.height; +20
        })
    }
    */
    
    // cancel button
     func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // save button
      func saveTapped(sender: AnyObject) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        // create a chatterfile object
        var chatterfile = NSEntityDescription.insertNewObjectForEntityForName("ChatterFile", inManagedObjectContext: context) as! ChatterFile
        chatterfile.name = chatterTextField.text
        chatterfile.url = self.audioURL
        
        // save sound to core data
        context.save(nil)
        
        // dismiss this view controller
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // record button
     func recordTapped(sender: AnyObject) {
        if self.audioRecorder.recording { // if recording
            self.audioRecorder.stop()
            self.recordButton.setTitle("RECORD", forState: UIControlState.Normal)
        }else{ // if not recording
            var
            session = AVAudioSession.sharedInstance()
            session.setActive(true, error: nil)
            self.audioRecorder.record()
            self.recordButton.setTitle("Stop Recording", forState: UIControlState.Normal)
        }
        
    }

};

*/