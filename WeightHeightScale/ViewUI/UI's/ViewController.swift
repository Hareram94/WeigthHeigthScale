//
//  ViewController.swift
//  WeightHeightScale
//
//  Created by Hareram on 25/10/26.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: -------------VARIABLE
    var selectedWeight: String?
    var rangeStart = Measurement(value: 1.0, unit: UnitMass.kilograms)
    var rangeLength = Measurement(value: Double(100), unit: UnitMass.kilograms)
    var segments = Array<RulerSegmentUnit>()
    var colorOverridesEnabled = false
    
    //MARK: -------------IBOUTLET
    
    @IBOutlet weak var MBV: UIView!
    @IBOutlet weak var rulerMBV: RulerMultiUnitRuler!
    @IBOutlet weak var selectUnit: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSegmet()
        //        setupSegmentedControlStyle()
        setupKGRuler()
    }
    
    @IBAction func measureTypeSegmentActn(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            rangeStart = Measurement(value: 1.0, unit: UnitMass.kilograms)
            rangeLength = Measurement(value: Double(100), unit: UnitMass.kilograms)
            self.setupKGRuler()
            //            weightRuler.refresh()
            
        }else{
            rangeStart = Measurement(value: 1.0, unit: UnitMass.pounds)
            rangeLength = Measurement(value: Double(100), unit: UnitMass.pounds)
            
            self.setupLbsRuler()
            //            weightRuler.refresh()
            
        }
    }
    
    @IBAction func goToHeight(_ sender: UIButton){
        
        setupNav()
    }
    
    private func setupNav(){
        // 1. Access the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // 2. Instantiate using the unique Storyboard ID identifier
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "HeightViewController") as? HeightViewController {
            
            // 3. Push it onto the stack
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    func setUpSegmet(){
        selectUnit.setTitle("kg", forSegmentAt: 0)
        selectUnit.setTitle("lbs", forSegmentAt: 1)
        setUISegmentControlAppearance()
    }
    
    func setUISegmentControlAppearance() {
        //        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        //        UISegmentedControl.appearance().backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
        
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 14.0, weight: .semibold)], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 14.0, weight: .semibold)], for: .selected)
    }
    
    //MARK: ------------setup segmantstyle
    func setupSegmentedControlStyle(){
        let unselectedBackgroundImage = UIImage(color: UIColor(red: 16/255.0, green: 17/255.0, blue: 19/255.0, alpha: 1))
        let selectedBacgroundImage = UIImage(color:UIColor.systemYellow)
        
        selectUnit.setBackgroundImage(unselectedBackgroundImage, for: .normal, barMetrics: .default)
        selectUnit.setBackgroundImage(unselectedBackgroundImage, for: .highlighted, barMetrics: .default)
        selectUnit.setBackgroundImage(selectedBacgroundImage, for: .selected, barMetrics: .default)
        
        selectUnit.setDividerImage(selectedBacgroundImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        selectUnit.layer.borderWidth = 0
        selectUnit.layer.borderColor = UIColor.clear.cgColor
    }
}

//MARK: ----------------MAKE KG SCALE
extension ViewController{
    
    //MARK: -----------------MAKE RULER FOR WEIGHT
    func setupKGRuler(){
        rulerMBV.backgroundColor = UIColor.clear
        segments = self.createSegments()
        rulerMBV.delegate = self
        rulerMBV.dataSource = self
        rulerMBV.direction = .horizontal
        let initialValue = (self.rangeForUnit(UnitMass.kilograms).location + self.rangeForUnit(UnitMass.kilograms).length) / 2
        rulerMBV.measurement = NSMeasurement(
            doubleValue: Double(initialValue),
            unit: UnitMass.kilograms)
        
        self.view.layoutSubviews()
        self.view.layoutIfNeeded()
        
        rulerMBV.refresh()
        if let measurement = rulerMBV.measurement {
            rulerMBV.delegate?.valueChanged(measurement: measurement)
        }
    }
    
    private func createSegments() -> Array<RulerSegmentUnit> {
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .providedUnit
        let kgSegment = RulerSegmentUnit(name: "kg", unit: UnitMass.kilograms, formatter: formatter)
        
        kgSegment.name = "Kilogram"
        kgSegment.unit = UnitMass.kilograms
        
        let kgMarkerTypeMax = RulerRangeMarkerType(color: UIColor.gray, size: CGSize(width: 1.0, height: 55.0), scale: 1.0)
        kgMarkerTypeMax.labelVisible = true
        //35 -> 25
        kgSegment.markerTypes = [
            RulerRangeMarkerType(color: UIColor(red: 57.0/255.0, green: 60.0/255.0, blue: 67.0/255.0, alpha: 1.0), size: CGSize(width: 1.0, height: 25.0), scale: 0.1),
            RulerRangeMarkerType(color: UIColor(red: 80.0/255.0, green: 83.0/255.0, blue: 91.0/255.0, alpha: 1.0), size: CGSize(width: 1.0, height: 55.0), scale: 1.0)
        ]
        
        kgSegment.markerTypes.last?.labelVisible = true
        return [kgSegment]
    }
}

//MARK:  -----------  MAKE LBS SCALE
extension ViewController{
    
    private func setupLbsRuler(){
        rulerMBV.backgroundColor = UIColor.clear
        segments = self.createSegmentsLbs()
        rulerMBV.delegate = self
        rulerMBV.dataSource = self
        rulerMBV.direction = .horizontal
        let initialValue = (self.rangeForUnit(UnitMass.pounds).location + self.rangeForUnit(UnitMass.pounds).length) / 2
        rulerMBV.measurement = NSMeasurement(
            doubleValue: Double(initialValue),
            unit: UnitMass.pounds)
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
        rulerMBV.refresh()
        if let measurement = rulerMBV.measurement {
            rulerMBV.delegate?.valueChanged(measurement: measurement)
        }
    }
    
    private func createSegmentsLbs() -> Array<RulerSegmentUnit> {
        
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .providedUnit
        let lbsSegment = RulerSegmentUnit(name: "Lbs", unit: UnitVolume.milliliters, formatter: formatter)
        
        lbsSegment.name = "Pounds"
        lbsSegment.unit = UnitMass.pounds
        
        let lbsMarkerTypeMax = RulerRangeMarkerType(color: UIColor.white, size: CGSize(width: 1.0, height: 50.0), scale: 10.0)
        
        lbsSegment.markerTypes = [
            RulerRangeMarkerType(color: UIColor(red: 57.0/255.0, green: 60.0/255.0, blue: 67.0/255.0, alpha: 1.0), size: CGSize(width: 1.0, height: 25.0), scale: 0.1),
            RulerRangeMarkerType(color: UIColor(red: 80.0/255.0, green: 83.0/255.0, blue: 91.0/255.0, alpha: 1.0), size: CGSize(width: 1.0, height: 50.0), scale: 1.0)
        ]
        
        lbsMarkerTypeMax.labelVisible = true
        lbsSegment.markerTypes.last?.labelVisible = true
        
        return [lbsSegment]
    }
    
}

//MARK: --------------------- RULER DELEGATE

extension ViewController: RulerMultiUnitRulerDelegate, RulerMultiUnitRulerDataSource {
    func valueChanged(measurement: NSMeasurement) {
        print("value changed to \(measurement.doubleValue)")
        self.selectedWeight = nil
        if let selectedTitle = selectUnit.titleForSegment(at: selectUnit.selectedSegmentIndex) {
            print("Selected segment title: \(selectedTitle)")
            let msValue = String(format: "%.2f", measurement.doubleValue)
            self.selectedWeight = msValue + selectedTitle
        }
    }
    
    func unitForSegmentAtIndex(index: Int) -> RulerSegmentUnit {
        return segments[index]
    }
    
    func rangeForUnit(_ unit: Dimension) -> RulerRange<Float> {
        
        if let massUnit = unit as? UnitMass {
            let locationConverted = rangeStart.converted(to: massUnit)
            let lengthConverted = rangeLength.converted(to: massUnit)
            
            return RulerRange<Float>(location: ceilf(Float(locationConverted.value)),
                                     length: ceilf(Float(lengthConverted.value)))
        }
        else {
            fatalError("Unsupported unit type: \(unit)")
        }
        
    }
    
    var numberOfSegments: Int {
        get {
            return segments.count
        }
        set {
            //
        }
    }
    
    func styleForUnit(_ unit: Dimension) -> RulerSegmentUnitControlStyle {
        let style: RulerSegmentUnitControlStyle = RulerSegmentUnitControlStyle()
        style.scrollViewBackgroundColor = UIColor.clear //It is used for background of scroll scale UIColor(red: 0.22, green: 0.74, blue: 0.86, alpha: 1.0)
        style.TopTextFieldFont = UIFont.systemFont(ofSize: 40.0, weight: .bold)
        let range = self.rangeForUnit(unit)
        if unit == UnitMass.pounds {
            
            style.textFieldBackgroundColor = UIColor.red
            //              color override location:location+40% red , location+60%:location.100% green
        } else {
            style.textFieldBackgroundColor = UIColor.black
        }
        
        if (colorOverridesEnabled) {
            style.colorOverrides = [
                RulerRange<Float>(location: range.location, length: 0.1 * (range.length)): UIColor.red,
                RulerRange<Float>(location: range.location + 0.4 * (range.length), length: 0.2 * (range.length)): UIColor.green]
        }
        style.textFieldBackgroundColor = UIColor.clear
        style.textFieldTextColor = UIColor.white
        return style
    }
    
}



