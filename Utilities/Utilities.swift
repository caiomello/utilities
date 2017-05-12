//
//  Utilities.swift
//  Utilities
//
//  Created by Caio Mello on May 11, 2017.
//  Copyright © 2017 Caio Mello. All rights reserved.
//

import UIKit

// MARK: - DateFormatter

extension DateFormatter {
	@nonobjc public static let shared: DateFormatter = {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.isLenient = true
		return formatter
	}()
}

// MARK: - Date

extension Date {
	public init(date: Date, hour: Int) {
		var components = Calendar.current.dateComponents([.year, .month, .day], from: date)
		components.hour = hour
		
		self.init(timeInterval: 0, since: Calendar.current.date(from: components)!)
	}
}

// MARK: - Array

extension Array {
	public func split(itemsPerSegment: IndexDistance) -> [[Element]] {
		let sequence = stride(from: startIndex, to: endIndex, by: itemsPerSegment)
		
		return sequence.map({
			let rangeEndIndex = $0.advanced(by: itemsPerSegment) > endIndex ? endIndex : $0.advanced(by: itemsPerSegment)
			return Array(self[$0..<rangeEndIndex])
		})
	}
}

// MARK: - Sequence

extension Sequence {
	public func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U: [Iterator.Element]] {
		var categories: [U: [Iterator.Element]] = [:]
		
		for element in self {
			let key = key(element)
			
			if case nil = categories[key]?.append(element) {
				categories[key] = [element]
			}
		}
		
		return categories
	}
}

// MARK: - Size

extension CGSize {
	public init(size: CGSize, aspectFitToWidth width: CGFloat) {
		let scaleFactor = width/size.width
		self.width = size.width * scaleFactor
		self.height = size.height * scaleFactor
	}
	
	public init(size: CGSize, aspectFitToHeight height: CGFloat) {
		let scaleFactor = height/size.height
		self.width = size.width * scaleFactor
		self.height = size.height * scaleFactor
	}
}

// MARK: - Rect

extension CGRect {
	public init(size: CGSize) {
		self.origin = CGPoint(x: 0, y: 0)
		self.size = size
	}
	
	public init(width: CGFloat, height: CGFloat) {
		self.init(size: CGSize(width: width, height: height))
	}
}

// MARK: - Interface Builder

@IBDesignable class CornerRadiusView: UIView {
	@IBInspectable fileprivate var cornerRadius: CGFloat = 0 {
		didSet {
			layer.cornerRadius = cornerRadius
		}
	}
}

@IBDesignable class CornerRadiusVisualEffectView: UIVisualEffectView {
	@IBInspectable fileprivate var cornerRadius: CGFloat = 0 {
		didSet {
			layer.cornerRadius = CGFloat(cornerRadius)
		}
	}
}

// MARK: - ImageView

extension UIImageView {
	public func boundsOfImage() -> CGRect {
		if let image = self.image {
			let widthFactor = image.size.width/self.bounds.size.width
			let heightFactor = image.size.height/self.bounds.size.height
			
			let factor = fmax(widthFactor, heightFactor)
			
			let width = image.size.width/factor
			let height = image.size.height/factor
			
			let x = (self.bounds.size.width - width)/2
			let y = (self.bounds.size.height - height)/2
			
			return CGRect(x: x, y: y, width: width, height: height)
		}
		
		return CGRect.zero
	}
	
	public func addShadow() {
		clipsToBounds = false
		layer.shadowPath = UIBezierPath(rect: boundsOfImage()).cgPath
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 1
		layer.shadowRadius = 10
		layer.shadowOffset = CGSize(width: 0, height: 5)
	}
}

// MARK: - Image

extension UIImage {
	public convenience init(color: UIColor) {
		let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
		
		UIGraphicsBeginImageContext(rect.size)
		
		let context = UIGraphicsGetCurrentContext()!
		context.setFillColor(color.cgColor)
		context.fill(rect)
		
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		
		UIGraphicsEndImageContext()
		
		self.init(cgImage: image.cgImage!)
	}
}

// MARK: - ScrollView

extension UIScrollView {
	public func scrollToTop() {
		contentOffset.x = -contentInset.left
		contentOffset.y = -contentInset.top
	}
}

// MARK: - TableViewCell

extension UITableView {
	public func hideLastSeparator(withCell cell: UITableViewCell, indexPath: IndexPath) {
		cell.separatorInset.left = indexPath.row == numberOfRows(inSection: indexPath.section) - 1 ? CGFloat.greatestFiniteMagnitude : separatorInset.left
	}
}

// MARK: - TraitCollection

public enum SizeClass {
	case compactRegular
	case compactCompact
	case regularCompact
	case regularRegular
}

extension UITraitCollection {
	public func sizeClass() -> SizeClass {
		if horizontalSizeClass == .compact && verticalSizeClass == .regular {
			return .compactRegular
		} else if horizontalSizeClass == .compact && verticalSizeClass == .compact {
			return .compactCompact
		} else if horizontalSizeClass == .regular && verticalSizeClass == .compact {
			return .regularCompact
		}
		
		return .regularRegular
	}
}
