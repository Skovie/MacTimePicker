//
//  TimePickerStyle.swift
//
//
//  Created by Bosco Ho on 2024-10-31.
//

import SwiftUI

@available(macOS 10.15, *)
@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public extension DatePickerStyle where Self == TimePickerStyle {
    
    static func timeIntervalField(
        _ interval: Binding<TimeInterval>? = nil,
        _ mode: Binding<TimePickerMode>? = nil
    ) -> TimePickerStyle {
        .init(interval: interval)
    }
}

public struct TimePickerStyle: DatePickerStyle {
    @Binding var interval: TimeInterval
    @Binding var mode: TimePickerMode
    public init(interval: Binding<TimeInterval>? = nil, mode: Binding<TimePickerMode>? = nil) {
        _interval = interval ?? .init(get: {
            return 0
        }, set: { _ in
            return
        })
        _mode = mode ?? .init(get: {
            return .clock
        }, set: { _ in
            return
        })
    }
   
    public func makeBody(configuration: Configuration) -> some View {
#if os(macOS)
        TimePicker(
            selection: configuration.$selection,
            mode: $mode,
            interval: $interval,
            displayedComponents: TimePickerComponents.allCases
        )
#else
        DatePicker(
            selection: configuration.selection,
            displayedComponents: configuration.displayedComponents,
            label: configuration.label
        )
#endif
    }
}
