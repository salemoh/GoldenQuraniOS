//
//  NetworkManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/23/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//
import Alamofire
import UIKit

class NetworkManager: NSObject {
    
    class func downloadFile(withUrl:String ,toPath:String , fileName:String , completion: ((Bool)->Void)? = nil , progressHandler: ((Double)->Void)? = nil ) {
        
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var saveFileURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0].appendingPathComponent(toPath)
//            do {
//                try FileManager.default.createDirectory(at: saveFileURL, withIntermediateDirectories: true, attributes: nil)
//            } catch  {
//                debugPrint("cannot create file directory ")
//            }
            
            saveFileURL.appendPathComponent(fileName)
            return (saveFileURL, [.removePreviousFile , .createIntermediateDirectories])
            
        }
        
        Alamofire.download(
            withUrl,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: nil,
            to: destination).downloadProgress(closure: { (progress) in
                //progress closure
                let progressValue = Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
                progressHandler?(progressValue)
                print(progress.completedUnitCount / progress.totalUnitCount  , progress)
            }).response(completionHandler: { (DefaultDownloadResponse) in
                //here you able to access the DefaultDownloadResponse
                //result closure
                if let _ = DefaultDownloadResponse.error {
                    completion?(false)
                } else {
                    completion?(true)
                }
                #if Debug
                    print(DefaultDownloadResponse)
                #endif
                //print(DefaultDownloadResponse)
            })
        
    }

}
