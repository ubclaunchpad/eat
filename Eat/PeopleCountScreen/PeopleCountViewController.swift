//
//  PeopleCountViewController.swift
//  Eat
//
//  Created by Sarina Chen on 2018-02-16.
//  Copyright © 2018 launchpad. All rights reserved.
//

import UIKit

class PeopleCountViewController: UIViewController {
  @IBOutlet weak var minusButton: UIButton!
  @IBOutlet weak var countButton: UIButton!
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var subheaderLabel: UILabel!
  var peopleCount: Int = 1

  override func viewDidLoad() {
      super.viewDidLoad()
      setupButtons()
      setupLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func countButtonTapped(_ sender: Any) {
    if peopleCount < 10 {
      peopleCount += 1
      scaleButton()
    }
    countButton.setTitle(String(peopleCount), for: .normal)
  }

  @IBAction func minusButtonTapped(_ sender: Any) {
    if peopleCount > 1 {
      peopleCount -= 1
      scaleButton()
    }
    countButton.setTitle(String(peopleCount), for: .normal)
  }

  private func setupButtons(){
    countButton.layer.cornerRadius = 0.5 * countButton.bounds.size.width
    countButton.clipsToBounds = true
    countButton.backgroundColor = .gray

    minusButton.layer.cornerRadius = 0.5 * minusButton.bounds.size.width
    minusButton.clipsToBounds = true
    minusButton.backgroundColor = #colorLiteral(red: 0.9621867069, green: 0.9621867069, blue: 0.9621867069, alpha: 1)
    minusButton.layer.borderColor = #colorLiteral(red: 0.908728585, green: 0.908728585, blue: 0.908728585, alpha: 1)
    minusButton.layer.borderWidth = 1.0
  }

  private func scaleButton(){
    let scale = 1.0 + Double(self.peopleCount)/5.0 * Double(self.peopleCount)/10.0
    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
      self.countButton.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
    }, completion: nil)
  }

  private func setupLabels(){
    headerLabel.font = Font.header(size: 20)
    subheaderLabel.font = Font.body(size: 18)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
