//
//  MushafPageManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/22/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
import Foundation

class MushafPageManager: NSObject {
    
    var pageHighlightRects = [HighlightRect]()
    var pageTopics = [MushafTopic]()
    var pageNumber:Int = 0
    
    weak var mushafPage:MushafPageViewController?
    
    func drawMushafTopics(){
        self.getMushafTopics()
        
        for pageTopic in pageTopics {
            for highlightRect in pageHighlightRects {
                if highlightRect.sora! == highlightRect.sora! && highlightRect.ayah! >= pageTopic.fromAyah! && highlightRect.ayah! <= pageTopic.toAyah!  {
                    
                    self.mushafPage?.drawHighlightRects(highlightRects: [highlightRect] , highlightType: .topic , highlightColor:pageTopic.color )
                }
                
            }
        }
        
    }
    func getMushafTopics(){
        loadHighlightRects(forPage: self.pageNumber)
        
        pageTopics.removeAll()
        var verseMin = 0
        var verseMax = 0
        var lastSora = 0
        
        var currentIndex = 0;
        for highlightItem in self.pageHighlightRects {
            if verseMin == 0 {
                verseMin = highlightItem.ayah!
            }
            if lastSora != highlightItem.sora && lastSora != 0 || currentIndex == (self.pageHighlightRects.count - 1)  {
                verseMax = highlightItem.ayah!
             print("verseMax:\(verseMax) verseMin:\(verseMin) lastSora:\(lastSora)")
                pageTopics += DBManager.shared.getMushafByTopic(formAyah: verseMin, toAyah: verseMax, soraNo: lastSora)
                verseMin = 0
                verseMax = 0
                lastSora = 0
            }
            lastSora = highlightItem.sora!
            currentIndex += 1
        }
        
        print(pageTopics)
    }
    
    func getHighlightRectForTouchPoint(point:CGPoint , inPage:Int) -> [HighlightRect] {
        
        mushafPage?.removeHighlights(forType: .highlight)
        var foundHighlightRect:HighlightRect?
        var verseHighlightRects = [HighlightRect]()
        
        if pageHighlightRects.count == 0  {
            loadHighlightRects(forPage: inPage)
        }
        
        
        for highlightRect in pageHighlightRects {
            if CGFloat(highlightRect.x!) <= point.x && point.x < CGFloat(highlightRect.width! + highlightRect.x!)  && CGFloat(highlightRect.y!) <= point.y && point.y < CGFloat(highlightRect.height! + highlightRect.y!) {
                
                foundHighlightRect = highlightRect
                break
            }
        }
        if (foundHighlightRect == nil) {
            return verseHighlightRects
        }
        
        for highlightRect in pageHighlightRects {
            if highlightRect.ayah == foundHighlightRect?.ayah {
                verseHighlightRects.append(highlightRect)
            }
        }
        
        return verseHighlightRects
    }
    
    func loadHighlightRects(forPage:Int) {
        
        if pageHighlightRects.count > 0 {
            return
        }
        
        pageHighlightRects = DBManager.shared.getMus7afHighlightRects(forPage: forPage + Mus7afManager.shared.currentMus7af.startOffset! , fromMushafDB: Mus7afManager.shared.currentMus7af.dbName!)
        
    }
    
    func handleUserTouchPoint(touchLocation: CGPoint) {
        let touchPoint = CGPoint(x:touchLocation.x / (mushafPage?.pageScaleFactor)!,y:touchLocation.y / (mushafPage?.pageScaleFactor)!)
        let highlightRects = self.getHighlightRectForTouchPoint(point: touchPoint, inPage: (mushafPage?.pageNumber)! )
        self.mushafPage?.drawHighlightRects(highlightRects: highlightRects , highlightType: .highlight , highlightColor: nil)
    }
    
}
