//
//  ViewController.swift
//  SimpleStockApp
//
//  Created by Eric on 5/19/15.
//  Copyright (c) 2015 Eric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var stockView: StockAppTableView!
    @IBOutlet var stockField: UITextField!
    var stocksArray:NSMutableArray = NSMutableArray()
    var stocksDictionary:NSMutableDictionary = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stockView.dataSource = stockView
        stockView.stocksArray = stocksArray
        stockView.stocksDictionary = stocksDictionary
        stockView.allowsMultipleSelection = false
        
        SIOSocket.socketWithHost("http://localhost:3000") { (socket: SIOSocket!) in
            socket.on("message", callback: {(AnyObject data) -> Void in
                var stockDictionary:NSDictionary = (data as NSArray).objectAtIndex(0) as NSDictionary
                var cell:StockAppTableViewCell? = self.stocksDictionary.valueForKey(stockDictionary.valueForKey("symbol") as NSString) as StockAppTableViewCell?
                
                if (cell? != nil) {
                    cell?.symbol!.text = stockDictionary.valueForKey("symbol") as NSString
                    cell?.price.text = stockDictionary.valueForKey("price")?.stringValue
                    cell?.history.text = stockDictionary.valueForKey("history") as NSString
                } else {
                    cell = self.stockView.dequeueReusableCellWithIdentifier("cell1") as StockAppTableViewCell?
                    cell?.symbol.text = stockDictionary.valueForKey("symbol") as NSString
                    cell?.price.text = stockDictionary.valueForKey("price")?.stringValue
                    cell?.history.text = stockDictionary.valueForKey("history") as NSString
                    
                    self.stocksArray.addObject(cell!)
                    let k:NSString? = cell?.symbol.text
                    self.stocksDictionary.setValue(cell, forKey: k!)
                    
                    let arr:NSArray = NSArray(object: NSIndexPath(forRow: self.stocksArray.count - 1, inSection: 0))
                    self.stockView.insertRowsAtIndexPaths(arr, withRowAnimation: .Bottom)
                }
            })
            socket.on("delete", callback: {(AnyObject data) -> Void in
                var stockDictionary:NSDictionary = (data as NSArray).objectAtIndex(0) as NSDictionary
                var cell:StockAppTableViewCell? = self.stocksDictionary.valueForKey(stockDictionary.valueForKey("symbol") as NSString) as StockAppTableViewCell?
                var index:Int = self.stocksArray.indexOfObject(cell!)
                self.stocksArray.removeObject(cell!)
                let k:NSString? = cell?.symbol.text
                self.stocksDictionary.removeObjectForKey(k!)
                
                let arr:NSArray = NSArray(object: NSIndexPath(forRow: index, inSection: 0))
                self.stockView.deleteRowsAtIndexPaths(arr, withRowAnimation: .Bottom)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAction(sender: AnyObject) {
        let symbol:String = stockField.text
        var urlStr:String = "http://localhost:3000/add/"
        urlStr += symbol
        let url:NSURL? = NSURL(string: urlStr)
        let request:NSURLRequest = NSURLRequest(URL: url!)
        NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        stockField.resignFirstResponder()
        stockField.text = ""
    }
}

