//
//  HeightViewController.swift
//  WeightHeightScale
//
//  Created by Hareram on 27/10/26.
//

import UIKit

class HeightViewController: UIViewController {

    //MARK: -------------VARIABLE
    var selectedHeight:String?
    var heightPicker = HeightPickerControl()
    var titleFeetLbl = UILabel()
    
    
    //MARK: -------------IBOUTLET
    @IBOutlet weak var selectUnit: UISegmentedControl!
    @IBOutlet weak var scaleMBV: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupFeetRuler()
        
    }
    
    @IBAction func selectUnitActn(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            self.setupFeetRuler()
        }else{
            self.setupCMSRuler()
        }
    }
    

}

extension HeightViewController{
    
    //MARK: -----------------MAKE RULER FOR WEIGHT
    
   private func setupFeetRuler(){
        heightPicker.removeFromSuperview()
        titleFeetLbl.removeFromSuperview()
        titleFeetLbl  = UILabel()
        titleFeetLbl.text = nil
        heightPicker = HeightPickerControl()
        heightPicker.translatesAutoresizingMaskIntoConstraints = false
        heightPicker.unit = .feetInches
        heightPicker.maxFeet = 300
        heightPicker.addTarget(self, action: #selector(heightChanged(_:)), for: .valueChanged)
        heightPicker.backgroundColor = UIColor.clear
        heightPicker.rulerViewBgColor = UIColor.clear
        scaleMBV.addSubview(heightPicker)
        titleFeetLbl.backgroundColor = UIColor.clear
        titleFeetLbl.textColor = UIColor.white
        titleFeetLbl.textAlignment = .right
        scaleMBV.addSubview(titleFeetLbl)
        titleFeetLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightPicker.trailingAnchor.constraint(equalTo: scaleMBV.trailingAnchor, constant: 10),
            heightPicker.centerYAnchor.constraint(equalTo: scaleMBV.centerYAnchor),
            heightPicker.widthAnchor.constraint(equalToConstant: 250),
            heightPicker.heightAnchor.constraint(equalTo: scaleMBV.heightAnchor, multiplier: 0.96),
            titleFeetLbl.leadingAnchor.constraint(equalTo: heightPicker.leadingAnchor, constant: -170),
            titleFeetLbl.centerYAnchor.constraint(equalTo: scaleMBV.centerYAnchor),
            titleFeetLbl.widthAnchor.constraint(equalTo: heightPicker.widthAnchor, multiplier: 1.0),
            titleFeetLbl.heightAnchor.constraint(equalTo: heightPicker.heightAnchor, multiplier: 0.8)
        ])
        
        self.scrollScale(inputView: heightPicker)
    }
    
    private func scrollScale(inputView: UIView){
        
        if let scrollView = inputView.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
            print("Found scroll view: \(scrollView)")
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
        
//        if let scrollView = inputView.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
//            print("Found scroll view: \(scrollView)")
//            scrollView.setContentOffset(CGPoint(x: 0, y: 10), animated: true)
//        }
    }
    
    //MARK: ----------------GETTING VALUE FROM SCALE
    @objc func heightChanged(_ sender: HeightPickerControl) {
        print("Selected: \(sender.selectedFeet)ft \(sender.selectedInches)in")
        
        let feetAttributes = [
            .font: UIFont.systemFont(ofSize: 40, weight: .bold),
            .foregroundColor: UIColor.white
        ] as [NSAttributedString.Key : Any]
        
        let ftAttributes = [
            .font: UIFont.systemFont(ofSize: 25.0, weight: .semibold),
            .foregroundColor: UIColor.darkGray
        ] as [NSAttributedString.Key : Any]
        
        //----------------Getting unit
        switch sender.unit {
         case .feetInches:
             print("Selected: \(sender.selectedFeet) ft \(sender.selectedInches) in")
            
            self.selectedHeight = nil
            self.selectedHeight = "\(sender.selectedFeet)ft\(sender.selectedInches)"
                        
            var attributedParts: [AttributedStringComponent] = [
                NSAttributedString(string: "\(sender.selectedFeet)", attributes: feetAttributes),
                NSAttributedString(string: "ft", attributes: ftAttributes)
            ]
        
            if sender.selectedInches > 0 {
                attributedParts.append(NSAttributedString(string: "\(sender.selectedInches)", attributes: feetAttributes))
                attributedParts.append(NSAttributedString(string: "in", attributes: ftAttributes))
            }

            self.titleFeetLbl.attributedText = NSAttributedString(from: attributedParts, defaultAttributes: feetAttributes)
            
         case .centimeters:
             print("Selected: \(sender.selectedCM) cm")
            
            self.selectedHeight = nil
            self.selectedHeight = "\(sender.selectedCM)cm"
            
            let attributedParts: [AttributedStringComponent] = [
                NSAttributedString(string: formatNumber(sender.selectedCM), attributes: feetAttributes),
                NSAttributedString(string: "cm", attributes: ftAttributes)
            ]
                        
            self.titleFeetLbl.attributedText = NSAttributedString(from: attributedParts, defaultAttributes: feetAttributes)
         }
    }
    
    private func formatNumber(_ number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(number)) // Remove decimal
        } else {
            return String(number) // Keep decimal
        }
    }
}

extension HeightViewController{
    
    //MARK: -----------------MAKE RULER FOR WEIGHT
    
    func setupCMSRuler(){
        heightPicker.removeFromSuperview()
        titleFeetLbl.removeFromSuperview()
        titleFeetLbl  = UILabel()
        titleFeetLbl.text = nil
        heightPicker = HeightPickerControl()
        heightPicker.translatesAutoresizingMaskIntoConstraints = false
        heightPicker.unit = .centimeters
        heightPicker.maxCM = 650.0
        heightPicker.addTarget(self, action: #selector(heightChanged(_:)), for: .valueChanged)
        heightPicker.backgroundColor = UIColor.clear
        heightPicker.rulerViewBgColor = UIColor.clear
        scaleMBV.addSubview(heightPicker)
        titleFeetLbl.backgroundColor = UIColor.clear
        titleFeetLbl.textColor = UIColor.white
        titleFeetLbl.textAlignment = .right
        scaleMBV.addSubview(titleFeetLbl)
        titleFeetLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightPicker.trailingAnchor.constraint(equalTo: scaleMBV.trailingAnchor, constant: 10),
            heightPicker.centerYAnchor.constraint(equalTo: scaleMBV.centerYAnchor),
            heightPicker.widthAnchor.constraint(equalToConstant: 250),
            heightPicker.heightAnchor.constraint(equalTo: scaleMBV.heightAnchor, multiplier: 0.96),
            titleFeetLbl.leadingAnchor.constraint(equalTo: heightPicker.leadingAnchor, constant: -170),
            titleFeetLbl.centerYAnchor.constraint(equalTo: scaleMBV.centerYAnchor),
            titleFeetLbl.widthAnchor.constraint(equalTo: heightPicker.widthAnchor, multiplier: 1.0),
            titleFeetLbl.heightAnchor.constraint(equalTo: heightPicker.heightAnchor, multiplier: 0.8)
        ])
        
        self.scrollScale(inputView: heightPicker)
    }
    
}
