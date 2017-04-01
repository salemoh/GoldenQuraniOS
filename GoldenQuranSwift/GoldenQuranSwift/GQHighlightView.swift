//
//  GQHighlightView.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/23/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

enum HighlightType:Int {
    case highlight
    case bookmark
    case note
    case topic
    case share
    
    func getColorForHighlight() -> UIColor? {
        switch self {
        case .highlight:
            return UIColor.blue.withAlphaComponent(0.3)
        case .bookmark:
            return UIColor.yellow.withAlphaComponent(0.3)
        case .note:
            return UIColor.green.withAlphaComponent(0.3)
        case .topic:
            return nil
        default:
            return UIColor.clear
        }
    }
}

class GQHighlightView: UIView {
    fileprivate var _highlightType:HighlightType = .highlight
    
    var highlightType:HighlightType  {
        get {
            return _highlightType
        }
        set{
            _highlightType = newValue
            if let color = _highlightType.getColorForHighlight(){
                self.backgroundColor = color
            }
        }
    }
}
