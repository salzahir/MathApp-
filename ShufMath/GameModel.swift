//
//  Game.swift
//  edutainment
//
//  Created by Salman Z on 12/23/24.
//

import Foundation

/// Manages the core game logic for math practice, including question generation,
/// scoring, and statistics tracking
struct GameModel{

    /// Represents a question in the game, including the text, the correct answer, and user input.
    struct Question: Codable, Identifiable {
        var id = UUID()
        var questionText: String
        var correctAnswer: Double
        var useInteger: Bool
        var userAnswer: Double?
        var timeTaken: Double
    }
    
    /// Tracks user performance across multiple games
    struct UserStats: Codable {
        var gamesPlayed: Int = 0
        var gamesWon: Int = 0 // Win requires > 70% correct answers
        var highestScore: Int = 0
        var averageScore: Double = 0.0
        var totalScore: Int = 0
        var gamesLost: Int = 0
        var perfectGames: Int = 0
        var longestStreak: Int = 0

        /// Updates the user’s statistics after each game, including their score, win/loss record, and average score.
        mutating func updateUserStats(score: Int, totalQuestions: Int, highestStreak: Int){
            
            gamesPlayed += 1
            totalScore += score
            
            // If player got at least 70% Considered a win/passing
            let winCondition = Double(totalQuestions) * 0.7
            
            if Double(score) > winCondition {
                gamesWon += 1
            }
            
            gamesLost = gamesPlayed - gamesWon
            
            // Updates the highest score if necessary
            if score > highestScore {
                highestScore = score
            }
            
            if highestStreak > longestStreak {
                longestStreak = highestStreak
            }
            
            averageScore = Double(totalScore) / Double(gamesPlayed)
        }
    }
    
    // Game properties
    
    let marginCheck = 0.1     /// Margin of error for decimal answers (0.1)
    var userStats: UserStats = UserStats()
    var index = 0
    var totalQuestions = 0
    var correctAnswers = 0
    var skips = 3
    var questionsArr: [Question] = []
    var highScore = 0
    var maxMultiplier = 2
    var midPoint = 0
    var gameChoice = 1
    var questionChoices = 1...30
    var timerAmount: Double = 0.0
    var timeLimit: Double = 0.0
    var currentStreak = 0
    var highestStreak = 0

    /// Different possible game states
    enum GameState {
        case notStarted
        case inProgress
        case finished
    }
    
    /// Different Difficulties available
    enum GameDifficulty {
        case easy
        case medium
        case hard
        case custom
        case random
    }
    
    /// The different game modes users can play (types of questions)
    enum GameMode: String, CaseIterable {
        case multiplication = "Multiplication"
        case division = "Division"
        case mixed = "Mixed Mode"
    }
    
    /// Represents alert messages that may appear during the game.
    enum AlertMessage: String {
        case blank = ""
        case selectDifficulty = "Please select a difficulty."
        case timesUp = "Times Up!"
        case correctAnswer = "Correct +1 Point"
        case incorrectAnswer = "Incorrect -1 Point"
        case incorrectNoPoint = "Incorrect No Point"
        case skippedQuestion = "Question Skipped Successfully No Point"
        case outOfSkips = "Out of skips"
        case lastQuestionSkipped = "Last Question skipped game over"
        case halfway = "\n\nYou reached half way!"
        case emptyInput = "Empty input, please enter a number."
        case invalidInput = "Invalid Input please enter a valid number."
        case streakLost = "You lost your streak"
    }
}