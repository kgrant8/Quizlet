//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4 // Number of questions per round
    var questionsAsked = 0    // Number of questions already asked
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var gameSound: SystemSoundID = 0
    var wrongAnswerSound: SystemSoundID = 1
    var correctAnswerSound: SystemSoundID = 2
    var gameOverSound: SystemSoundID = 3
    var askedQuestions = [Int]()    // array of the indexs of questions already asked, reset after every round
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var aButton: UIButton! // option A
    @IBOutlet weak var bButton: UIButton! // option B
    @IBOutlet weak var cButton: UIButton! // option C
    @IBOutlet weak var dButton: UIButton! // option D
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // This function Displays the Questions to the view.
    func displayQuestion() {
        
        indexOfSelectedQuestion = GetRandomNumber(quiz.count)
        
        
        //Setting all buttons to the nutrual color
        aButton.backgroundColor = AnswerColor
        bButton.backgroundColor = AnswerColor
        cButton.backgroundColor = AnswerColor
        dButton.backgroundColor = AnswerColor
        
        questionField.text = quiz[indexOfSelectedQuestion].question
        //Shuffling Answer choices so that they dont always show up in the correct order.
        ShuffleAnswers(quiz[indexOfSelectedQuestion])
        
        playAgainButton.hidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        aButton.hidden = true
        bButton.hidden = true
        cButton.hidden = true
        dButton.hidden = true
        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    // Onclick of button we are checking here if the answer is correct. Correct answers have a sender.tag = 1; all others have a tag of 0
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        switch sender.tag {
        case 1:
            correctQuestions += 1
            questionField.text = "Correct!"
            sender.backgroundColor = CorrectLabelColor
            playCorrectAnswerSound()
            break;
            
        default:
            sender.backgroundColor = WrongLabelColor
            ShowCorrectAnswer()
            playWrongAnswerSound()
            questionField.text = "Sorry, wrong answer!"
            break;
        }
        
        
        //Auto load the next question with a 2 second delay.
        loadNextRoundWithDelay(seconds: 2)
    }
    
    //This function just shows/turns the correct answer green. CorrectLabelColor is a const. found in ColorModel.
    func ShowCorrectAnswer() {
        
        if (aButton.tag == 1){
            aButton.backgroundColor = CorrectLabelColor
            return
        }
        if (bButton.tag == 1){
            bButton.backgroundColor = CorrectLabelColor
            return
        }
        if (cButton.tag == 1){
            cButton.backgroundColor = CorrectLabelColor
            return
        }
        if (dButton.tag == 1){
            dButton.backgroundColor = CorrectLabelColor
            return
        }
        
    }
    
    //Shuffles the choices around so not every answer is A.
    func ShuffleAnswers (q:Question) {
        
        let shuffleButtons  =  [aButton,bButton,cButton,dButton]
        
        let randomAnswerIndex = GKRandomSource.sharedRandom().nextIntWithUpperBound(shuffleButtons.count)
        var x: Int = 0
        
        
        for i in 0 ..< shuffleButtons.count{
            
            if i != randomAnswerIndex{
                
                
                switch x {
                    
                case 0:
                    shuffleButtons[i].setTitle(q.wrongChoice1,forState: UIControlState.Normal)
                    shuffleButtons[i].tag = 0
                    
                    break
                case 1:
                    shuffleButtons[i].setTitle(q.wrongChoice2,forState: UIControlState.Normal)
                    shuffleButtons[i].tag = 0
                    break
                case 2:
                    shuffleButtons[i].setTitle(q.wrongChoice3,forState: UIControlState.Normal)
                    shuffleButtons[i].tag = 0
                    break
                    
                default:
                    print("Houston we have a problem!")
                }
                x += 1
            }
            else{
                shuffleButtons[randomAnswerIndex].setTitle(q.answer,forState: UIControlState.Normal)
                shuffleButtons[randomAnswerIndex].tag = 1
                
                
            }
            
            
            
            
        }
        
    }

    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            playGameOverSound()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        aButton.hidden = false
        bButton.hidden = false
        cButton.hidden = false
        dButton.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        askedQuestions = [Int]()
        nextRound()
    }
    
    //This function just returns a random number and also makes sure that the random number it returns has not been choosen before.
    //This function is used to select a question from the data set of questions in QuestionModel.swift
    
    func GetRandomNumber(seed: Int) -> Int{
        
        var number = 0;
        repeat {
            number = GKRandomSource.sharedRandom().nextIntWithUpperBound(seed)
            
            
        }while askedQuestions.contains(number)
        
        askedQuestions.append(number)
        return number
    }
    
        
    
    
        func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        
        //Start of the game sound
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        var soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
        
        //Correct Answer Sound bite
        let pathToCorrectAnswerSound = NSBundle.mainBundle().pathForResource("CorrectAnswer", ofType: "wav")
        soundURL = NSURL(fileURLWithPath: pathToCorrectAnswerSound!)
        AudioServicesCreateSystemSoundID(soundURL, &correctAnswerSound)
        
        //Wrong answer sound bite
        let pathToWrongAnswerSound = NSBundle.mainBundle().pathForResource("WrongAnswer", ofType: "wav")
        soundURL = NSURL(fileURLWithPath: pathToWrongAnswerSound!)
        AudioServicesCreateSystemSoundID(soundURL, &wrongAnswerSound)
        
        //Game over Sound
        let pathToGameOverSound = NSBundle.mainBundle().pathForResource("GameOver", ofType: "wav")
        soundURL = NSURL(fileURLWithPath: pathToGameOverSound!)
        AudioServicesCreateSystemSoundID(soundURL, &gameOverSound)

    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    func playGameOverSound() {
        AudioServicesPlaySystemSound(gameOverSound)
    }
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongAnswerSound)
    }
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctAnswerSound)
    }
    
}

