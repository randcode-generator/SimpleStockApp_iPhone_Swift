//
//  StockAppTableView.swift
//  SimpleStockApp_iPhone-Swift
//
//  Created by Eric on 5/18/15.
//  Copyright (c) 2015 Eric. All rights reserved.
//

import UIKit

class StockAppTableView: UITableView, UITableViewDataSource {
    var _stocksArray:NSMutableArray = NSMutableArray()
    var stocksArray:NSMutableArray {
        get {
            return _stocksArray
        }
        set(s) {
            _stocksArray = s
        }
    }
    
    var _stocksDictionary:NSMutableDictionary = NSMutableDictionary()
    var stocksDictionary:NSMutableDictionary {
        get {
            return _stocksDictionary
        }
        set(s) {
            _stocksDictionary = s
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:StockAppTableViewCell = stocksArray.objectAtIndex(indexPath.row) as StockAppTableViewCell
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: NSInteger) -> NSInteger {
        return stocksArray.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle:UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let cell:StockAppTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as StockAppTableViewCell
            var urlStr:String = "http://localhost:3000/delete/"
            urlStr += cell.symbol.text!
            let url:NSURL? = NSURL(string: urlStr)
            let request:NSURLRequest = NSURLRequest(URL: url!)
            NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        }
    }
}
