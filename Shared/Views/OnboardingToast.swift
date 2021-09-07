//
//  OnboardingToast.swift
//  Shuttle Tracker
//
//  Created by Gabriel Jacoby-Cooper on 8/31/21.
//

import SwiftUI

struct OnboardingToast: View {
	
	enum HeadlineText: String {
		
		case tip = "Here's a tip!"
		case reminder = "Just in case you forgot..."
		
	}
	
	private static let highQualityString = "Green buses have high-quality location data."
	
	private static let lowQualityString = "Red buses have low-quality location data."
	
	let headlineText: HeadlineText?
	
	@available(iOS 15, *) private static let highQualityAttributedString: AttributedString = {
			var attributedString = AttributedString(Self.highQualityString)
			let greenRange = attributedString.range(of: "Green")!
			let highQualityRange = attributedString.range(of: "high-quality")!
			attributedString[greenRange].foregroundColor = .green
			attributedString[highQualityRange].inlinePresentationIntent = .stronglyEmphasized
			return attributedString
	}()
	
	@available(iOS 15, *) private static let lowQualityAttributedString: AttributedString = {
		var attributedString = AttributedString(Self.lowQualityString)
		let redRange = attributedString.range(of: "Red")!
		let lowQualityRange = attributedString.range(of: "low-quality")!
		attributedString[redRange].foregroundColor = .red
		attributedString[lowQualityRange].inlinePresentationIntent = .stronglyEmphasized
		return attributedString
	}()
	
	@Binding private(set) var doShow: Bool
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text(self.headlineText?.rawValue ?? "Onboarding")
					.font(.headline)
				Spacer()
				Button {
					self.doShow = false
				} label: {
					Image(systemName: "xmark.circle.fill")
						.resizable()
						.frame(width: 25, height: 25)
				}
					.buttonStyle(.plain)
			}
			HStack {
				ZStack {
					Circle()
						.fill(.green)
					Image(systemName: "bus")
						.resizable()
						.frame(width: 30, height: 30)
						.foregroundColor(.white)
				}
					.frame(width: 50)
				if #available(iOS 15, *) {
					Text(Self.highQualityAttributedString)
				} else {
					Text(Self.highQualityString)
				}
			}
				.frame(height: 50)
			Spacer()
				.frame(height: 15)
			HStack {
				ZStack {
					Circle()
						.fill(.red)
					Image(systemName: "bus")
						.resizable()
						.frame(width: 30, height: 30)
						.foregroundColor(.white)
				}
					.frame(width: 50)
				if #available(iOS 15, *) {
					Text(Self.lowQualityAttributedString)
				} else {
					Text(Self.lowQualityString)
				}
			}
				.frame(height: 50)
		}
			.layoutPriority(0)
			.padding()
			.background(VisualEffectView(effect: UIBlurEffect(style: .systemMaterial)))
			.cornerRadius(30)
	}
	
}

struct OnboardingToastPreviews: PreviewProvider {
	
	static var previews: some View {
		OnboardingToast(headlineText: nil, doShow: .constant(true))
	}
	
}
