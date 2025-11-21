//
//  Debouncer.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import Foundation

final class Debouncer {
    private var workItem: DispatchWorkItem?
    private let queue: DispatchQueue
    private let delay: TimeInterval

    init(delay: TimeInterval, queue: DispatchQueue = .main) {
        self.delay = delay
        self.queue = queue
    }

    func call(_ block: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: block)
        if let item = workItem {
            queue.asyncAfter(deadline: .now() + delay, execute: item)
        }
    }
}
