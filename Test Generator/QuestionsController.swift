//
//  QuestionsController.swift
//  Test Generator
//
//  Created by Esha Shetty on 2019-11-19.
//  Copyright © 2019 Esha Shetty. All rights reserved.
//

import UIKit

//protocol  QuestionsControllerDelegate: class {
//
//    func questionViewControllerScore(_ controller: QuestionsController, didFinishAdding score: Int)
//}

class QuestionsController: UITableViewController {

    //variables to set the question rows for questions 1 through 5
    var Q1: [String]
    var Q2: [String]
    var Q3: [String]
    var Q4: [String]
    var Q5: [String]
    
    //counts which question the user is on
    var qCount = 1
    //keep score
    var score = 0
    //populates the array with all the values from the plist
    var qSet : [QuestionSet]
    
    //outlet variable
    @IBOutlet weak var scoreDisplay: UILabel!
    
    
   required init?(coder aDecoder: NSCoder) {
        //initialize the variables
        Q1 = [String]()
        Q2 = [String]()
        Q3 = [String]()
        Q4 = [String]()
        Q5 = [String]()
    
        qSet = [QuestionSet]()
    
      super.init(coder: aDecoder)
   }
   
    //populates the table with 5 rows for the questionaire
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    //table view delegate to perform an action when the user taps a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Quiz", for: indexPath)
        var userAns = ""
        if indexPath.row == 0{
            //disables cell selection for the first row as this is the question cell
            cell.isUserInteractionEnabled = false;
        }
        else{
                scoreDisplay.text = "Score: \(score)/ 5"
                if qCount == 1{
                    userAns = Q1[indexPath.row]
                    if userAns == qSet[0].answer{
                        score += 1
                    }
                    
                    tableView.reloadData()
                }
                else if qCount == 2{
                    userAns = Q2[indexPath.row]
                    if userAns == qSet[1].answer{
                        score += 1
                    }
                    
                    tableView.reloadData()
                }
                else if qCount == 3{
                    userAns = Q3[indexPath.row]
                    if userAns == qSet[2].answer{
                        score += 1
                    }
                    tableView.reloadData()
                }
                else if qCount == 4{
                    userAns = Q4[indexPath.row]
                    if userAns == qSet[3].answer{
                        score += 1
                    }
                    tableView.reloadData()
                }
                else if qCount == 5{
                    userAns = Q5[indexPath.row]
                    if userAns == qSet[4].answer{
                        score += 1
                    }
                }
                scoreDisplay.text = "Score: \(score)/ 5"
                qCount += 1
                
                //reloads the table view so that the cells can be populated with the new values
            
            if qCount == 6{
                
                if score == 0{
                    scoreDisplay.text = "0 / 5: Muggle..Go Back to Try Again"
                }
                else if score == 1{
                    scoreDisplay.text = "1 / 5: Muggle..Go Back to Try Again"
                }
                else if score == 2{
                    scoreDisplay.text = "2 / 5: Muggle..Go Back to Try Again"
                }
                else if score == 3{
                    scoreDisplay.text = "3 / 5: Decent! Try harder!"
                }
                else if score == 4{
                    scoreDisplay.text = "4 / 5: You are a decent wizard! "
                }
                else{
                    scoreDisplay.text = "5 / 5: Perfect! You are an Auror!!"
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Quiz", for: indexPath)
        var questionSet = ""
        
        if qCount == 1{
            questionSet = Q1[indexPath.row]
        }
        else if qCount == 2{
            questionSet = Q2[indexPath.row]
        }
        else if qCount == 3{
            questionSet = Q3[indexPath.row]
        }
        else if qCount == 4{
            questionSet = Q4[indexPath.row]
        }
        else if qCount == 5{
            questionSet = Q5[indexPath.row]
        }
        
        populateText(for: cell, with: questionSet)

        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //calls function to populates the question set
        loadQuestonSet()
        //shuffles the entire question set
        qSet.shuffle()
        //sets the string values from the question set to the question set arrays for each question which will be added to the cell based on the user's navigation
        Q1 = ["Q1) "+qSet[0].question,qSet[0].choices[0],qSet[0].choices[1],qSet[0].choices[2],qSet[0].choices[3]]
        Q2 = ["Q2) "+qSet[1].question,qSet[1].choices[0],qSet[1].choices[1],qSet[1].choices[2],qSet[1].choices[3]]
        Q3 = ["Q3) "+qSet[2].question,qSet[2].choices[0],qSet[2].choices[1],qSet[2].choices[2],qSet[2].choices[3]]
        Q4 = ["Q4) "+qSet[3].question,qSet[3].choices[0],qSet[3].choices[1],qSet[3].choices[2],qSet[3].choices[3]]
        Q5 = ["Q5) "+qSet[4].question,qSet[4].choices[0],qSet[4].choices[1],qSet[4].choices[2],qSet[4].choices[3]]
        
    }
 
    
    //populates the question set inside the cell
    func populateText(for cell: UITableViewCell,with questionSet: String) {
         let label = cell.viewWithTag(100) as! UILabel
         label.text = questionSet
    }
    
    //function to populate the list of questions from the pList
    func loadQuestonSet(){
        if let filePath = Bundle.main.path(forResource: "Questionaire", ofType: "plist"),
            let xmlFile = FileManager.default.contents(atPath: filePath),
            let qList = try?PropertyListDecoder().decode([QuestionSet].self, from: xmlFile){
                qSet = qList
        }
    }
}
