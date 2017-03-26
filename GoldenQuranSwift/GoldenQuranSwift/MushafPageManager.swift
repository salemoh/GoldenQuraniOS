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
    
    weak var mushafPage:MushafPageViewController?
    
    
    func getHighlightRectForTouchPoint(point:CGPoint , inPage:Int) -> [HighlightRect] {
        
        mushafPage?.removeAllHighlights()
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
        
        pageHighlightRects = DBManager.shared.getMus7afHighlightRects(forPage: forPage + Mus7afManager.shared.currentMus7af.startOffset! , fromMushafDB: Mus7afManager.shared.currentMus7af.dbName!)
        
    }
    
    func handleUserTouchPoint(touchLocation: CGPoint) {
        let touchPoint = CGPoint(x:touchLocation.x / (mushafPage?.pageScaleFactor)!,y:touchLocation.y / (mushafPage?.pageScaleFactor)!)
        let highlightRects = self.getHighlightRectForTouchPoint(point: touchPoint, inPage: (mushafPage?.pageNumber)! )
        self.mushafPage?.drawHighlightRects(highlightRects: highlightRects)
    }
    
}
