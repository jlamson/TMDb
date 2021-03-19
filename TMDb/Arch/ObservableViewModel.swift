//
//  Observer.swift
//  TMDb
//
//  Created by Joshua Lamson on 3/19/21.
//

import Foundation
import UIKit

class ObservableViewModel<VC : UIViewController, Data> {
    private(set) var current: Data? = nil
    private(set) var observations: [UUID : (Data) -> Void] = [:]
    
    @discardableResult
    func observeForLifetime(
        of observer: VC,
        _ closure: @escaping (VC, Data) -> Void
    ) -> ObservationToken {
        let id = UUID()
        observations[id] = { [weak self, weak observer] data in
            // If the observing object is no longer in memory, remove this observation
            guard let observer = observer else {
                self?.observations.removeValue(forKey: id)
                return
            }
            
            // Call the provided closure
            self?.onMain { closure(observer, data) }
        }
        
        let safeCurrent = current
        if (safeCurrent != nil) {
            onMain { closure(observer, safeCurrent!) }
        }

        return ObservationToken { [weak self] in
            self?.observations.removeValue(forKey: id)
        }
    }
    
    func publish(_ data: Data) {
        for (_, observer) in observations {
            onMain {
                // Ignore UUID, our wrapped observer above will check for presence of observer
                observer(data)
            }
        }
    }
    
    private func onMain(_ block: @escaping () -> Void) {
        DispatchQueue.main.async {
            block()
        }
}
}

class ObservationToken {
    private let cancellationClosure: () -> Void

    init(cancellationClosure: @escaping () -> Void) {
        self.cancellationClosure = cancellationClosure
    }

    func cancel() {
        cancellationClosure()
    }
}

