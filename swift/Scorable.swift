import Foundation

struct Score {
    private var value: Int

    init (_ value: Int) {
        self.value = value
    }
}

// Can this be included directly in the score struct definition?
extension Score {
    static func +(lhs: Score, rhs: Score) -> Score {
        return Score(lhs.value + rhs.value)
    }

    static func *(lhs: Score, rhs: Score) -> Score {
        return Score(lhs.value * rhs.value)
    }
}

protocol Scorable {
    func toScore() -> Score
}

enum Priority {
    case blocker, critical, high, medium, low, none
}

extension Priority: Scorable {
    func toScore() -> Score {
        // Score({
        //     switch self {
        //          case .blocker:
        //             return 5
        //         case .critical:
        //             return 4
        //         case .high:
        //             return 3
        //         case .medium:
        //             return 2
        //         case .low:
        //             return 1
        //         case .none:
        //             return 0
        //     }
        // }())

        Score([
            .blocker: 5,
            .critical: 4,
            .high: 3,
            .medium: 2,
            .low: 1,
            .none: 0
        ][self]!)
    }
}

enum Effort {
    case unknown, high, medium, low
}

extension Effort: Scorable {
    func toScore() -> Score {
        Score([
            .unknown: 4,
            .high: 3,
            .medium: 2,
            .low: 1
        ][self]!)
    }
}

func factor(_ lhs: Scorable, _ rhs: Scorable) -> Score {
    lhs.toScore() * rhs.toScore()
}


let score = Score(1)
print(score)
print(Priority.high.toScore())
print(factor(Effort.low, Priority.high))
