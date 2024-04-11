// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import HealthKit
import UserNotifications


final public class viewModelHealthKit: ObservableObject{
    
    public init (){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    //instancia de healthstore
    private let healthStore = HKHealthStore()
    
    private var observerQuery: HKObserverQuery?
    
    //Publicar en la vista
    @Published public var heartRate : String = "0"
    @Published public var oxygenSaturation : String = "0"
    @Published public var vo2Max : String = "0"
    @Published public var uvExposure : String = "0"
    @Published public var bodyTemperature : String = "0"
    @Published public var weight : String = "0"
    @Published public var height : String = "0"
    @Published public var age : String = "0"
    
    
    
    private var query: HKStatisticsQuery?
    
    
    
    public func requestAccessToHealthData(){
        let readableTypes: Set<HKObjectType> = [
            HKQuantityType(.heartRate),
            HKQuantityType(.oxygenSaturation),
            HKQuantityType(.vo2Max),
            HKQuantityType(.uvExposure),
            HKQuantityType(.bodyTemperature),
            HKQuantityType(.bodyMass),
            HKQuantityType(.height),
            HKCharacteristicType(.dateOfBirth)
        ]
        
        
        guard HKHealthStore.isHealthDataAvailable() else{
            print("Healthkit no esta disponible ")
            return
        }
        
        healthStore.requestAuthorization(toShare: nil, read: readableTypes){ success, error in
            DispatchQueue.main.async{
                if success{
                    print("Request Authorization \(success.description)")
                    self.getTodayHeartRate()
                    self.getTodayOxygenSaturation()
                    self.getTodayVo2Max()
                    self.getTodayUvExposure()
                    self.getTodaybodyTemperature()
                    self.getTodayWeight()
                    self.getTodayHeight()
                    self.getAge()
                }
            }

        }
    }
    
    public func getAge(){
        
        do{
            let birthDay = try healthStore.dateOfBirthComponents()
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date() )
            let age = currentYear - birthDay.year!
            self.age = String(Int(age))
        }catch{}
    }
    
    func getTodayHeartRate(){
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else{
            print("Error: identifier .heartRate")
            return
        }
       
        observerQuery = HKObserverQuery(sampleType: heartRateType, predicate: nil, updateHandler: { query, completionHandler, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.getHeartRateData()
            
        })
        observerQuery.map(healthStore.execute)
    }
    
    private func getHeartRateData(){
        let heartRateType = HKQuantityType(.heartRate)
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: heartRateType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil){ (query, results, error) in
            DispatchQueue.main.async{
                guard let result = results?.last as? HKQuantitySample else{
                    self.heartRate = String(Int(0))
                    return
                }
                self.heartRate = String(Int(result.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))))
                
                self.checkHeartRateData()
            }
            
        }
        healthStore.execute(query)
            
    }
    
    private func checkHeartRateData() {
        let heart = (self.heartRate as NSString).integerValue
        let highRiskThreshold = 100
        let lowRiskThreshold = 60
        
        let content = UNMutableNotificationContent()
        content.title = "You are in risk"
        content.subtitle = "Your Heart rate is \(heart)"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        if heart > highRiskThreshold {
            //print("You are at risk! Abnormal high heart rate: \(heart) BPM")
    
            UNUserNotificationCenter.current().add(request)
            
        } else if heart < lowRiskThreshold {
            //print("You are at risk! Abnormal low heart rate: \(heart) BPM")
            
            UNUserNotificationCenter.current().add(request)
        } else {
            print("Your heart rate is within normal range: \(heart) BPM")
        }
    }
    
    func getTodayOxygenSaturation(){
        guard let oxygenSaturationType = HKObjectType.quantityType(forIdentifier: .oxygenSaturation) else{
            print("Error: identifier .oxygenSaturation")
            return
        }
        observerQuery = HKObserverQuery(sampleType: oxygenSaturationType, predicate: nil, updateHandler: { query, completionHandler, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.getOxygenSaturationData()
        })
        observerQuery.map(healthStore.execute)
    }
    
    private func getOxygenSaturationData(){
        let oxygenSaturationType = HKQuantityType(.oxygenSaturation)
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: oxygenSaturationType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil){ (query, results, error) in
            
            DispatchQueue.main.async{
                guard let result = results?.last as? HKQuantitySample else{
                    self.oxygenSaturation = String(Int(0))
                    return
                }
                self.oxygenSaturation = String(Int(result.quantity.doubleValue(for: HKUnit(from: "%")) * 100))
                
                self.checkOxygenSaturationData()
            }
        }
        healthStore.execute(query)
    }
    
    private func checkOxygenSaturationData() {
        let oxygen = (self.oxygenSaturation as NSString).integerValue
        let highRiskThreshold = 100
        let lowRiskThreshold = 95
        
        let content = UNMutableNotificationContent()
        content.title = "You are in risk"
        content.subtitle = "Your oxygen saturation is: \(oxygen)"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        if oxygen > highRiskThreshold {
            //print("You are at risk! Abnormal high oxygen: \(heart)")
    
            UNUserNotificationCenter.current().add(request)
            
        } else if oxygen < lowRiskThreshold {
            //print("You are at risk! Abnormal low oxygen: \(heart)")
            
            UNUserNotificationCenter.current().add(request)
        } else {
            print("Your oxigen is within normal range: \(oxygen)")
        }
    }
    func getTodayVo2Max(){
        guard let vo2MaxType = HKObjectType.quantityType(forIdentifier: .vo2Max) else{
            print("Error: identifier .vo2Max")
            return
        }
        observerQuery = HKObserverQuery(sampleType: vo2MaxType, predicate: nil, updateHandler: { query, completionHandler, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.getVo2MaxData()
        })
        observerQuery.map(healthStore.execute)
    }
    private func getVo2MaxData(){
        let vo2MaxType = HKQuantityType(.vo2Max)
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: vo2MaxType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil){ (query, results, error) in
            DispatchQueue.main.async{
                guard let result = results?.last as? HKQuantitySample else{
                    self.vo2Max = String(Int(0))
                    return
                }
                self.vo2Max = String(Int(result.quantity.doubleValue(for: HKUnit(from: "ml/kg*min"))))
                
                self.checkVo2MaxData()
            }
        }
        healthStore.execute(query)
    }
    private func checkVo2MaxData() {
        let vo2max = (self.vo2Max as NSString).integerValue
        let highRiskThreshold = 60
        let lowRiskThreshold = 30
        
        let content = UNMutableNotificationContent()
        content.title = "vo2max"
        content.subtitle = "Your vo2max saturation is: \(vo2max)"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        if vo2max > highRiskThreshold {
            //print("You are at risk! Abnormal high vo2max: \(heart)")
    
            UNUserNotificationCenter.current().add(request)
            
        } else if vo2max < lowRiskThreshold {
            //print("You are at risk! Abnormal low vo2max: \(heart)")
            
            UNUserNotificationCenter.current().add(request)
        } else {
            print("Your vo2max is within normal range: \(vo2max)")
        }
    }
    func getTodayUvExposure(){
        guard let uvExposureType = HKObjectType.quantityType(forIdentifier: .uvExposure) else{
            print("Error: identifier .uvexposure")
            return
        }
        observerQuery = HKObserverQuery(sampleType: uvExposureType, predicate: nil, updateHandler: { query, completionHandler, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.getUvExposureData()
        })
        observerQuery.map(healthStore.execute)
    }
    
    private func getUvExposureData(){
        let uvExposureType = HKQuantityType(.uvExposure)
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: uvExposureType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil){ (query, results, error) in
            DispatchQueue.main.async{
                guard let result = results?.last as? HKQuantitySample else{
                    self.uvExposure = String(Int(0))
                    return
                }
                self.uvExposure = String(Int(result.quantity.doubleValue(for: HKUnit.count())))
                
                self.checkUvExposureData()
            }
            
        }
        healthStore.execute(query)
    }
    private func checkUvExposureData() {
        let uvExposure = (self.uvExposure as NSString).integerValue
        let highRiskThreshold = 6
        let lowRiskThreshold = 2
        
        let content = UNMutableNotificationContent()
        content.title = "uvExposure"
        content.subtitle = "Your uvExposure is: \(uvExposure)"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        if uvExposure > highRiskThreshold {
            //print("You are at risk! Abnormal high uvExposure: \(heart)")
    
            UNUserNotificationCenter.current().add(request)
            
        } else if uvExposure < lowRiskThreshold {
            //print("You are at risk! Abnormal low uvExposure: \(heart)")
            
            UNUserNotificationCenter.current().add(request)
        } else {
            print("Your uvExposure is within normal range: \(uvExposure)")
        }
    }
    
    func getTodaybodyTemperature(){
        guard let bodyTemperatureType = HKObjectType.quantityType(forIdentifier: .bodyTemperature) else{
            print("Error: identifier .bodyTemperature")
            return
        }
        observerQuery = HKObserverQuery(sampleType: bodyTemperatureType, predicate: nil, updateHandler: { query, completionHandler, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.getBodyTemperatureData()
        })
        observerQuery.map(healthStore.execute)
    }
    
    private func getBodyTemperatureData(){
        let bodyTemperatureType = HKQuantityType(.bodyTemperature)
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: bodyTemperatureType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil){ (query, results, error) in
            DispatchQueue.main.async{
                guard let result = results?.last as? HKQuantitySample else{
                    self.bodyTemperature = String(Int(0))
                    return
                }
                self.bodyTemperature = String(result.quantity.doubleValue(for: HKUnit.degreeFahrenheit()))
                
                self.checkBodyTemperatureData()
            }
            
        }
        healthStore.execute(query)
    }
    
    private func checkBodyTemperatureData() {
        let bodyTemperature = (self.bodyTemperature as NSString).integerValue
        let highRiskThreshold = 39
        let lowRiskThreshold = 35
        
        let content = UNMutableNotificationContent()
        content.title = "bodyTemperature"
        content.subtitle = "Your bodyTemperature is: \(bodyTemperature)"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        if bodyTemperature > highRiskThreshold {
            //print("You are at risk! Abnormal high bodyTemperature: \(heart)")
    
            UNUserNotificationCenter.current().add(request)
            
        } else if bodyTemperature < lowRiskThreshold {
            //print("You are at risk! Abnormal low bodyTemperature: \(heart)")
            
            UNUserNotificationCenter.current().add(request)
        } else {
            print("Your bodyTemperature is within normal range: \(bodyTemperature)")
        }
    }
    
    func getTodayWeight(){
        guard let weightType = HKObjectType.quantityType(forIdentifier: .bodyMass) else{
            print("Error: identifier .bodymass")
            return
        }
        observerQuery = HKObserverQuery(sampleType: weightType, predicate: nil, updateHandler: { query, completionHandler, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.getWeightData()
        })
        observerQuery.map(healthStore.execute)
    }
    
    private func getWeightData(){
        let weightType = HKQuantityType(.bodyMass)
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: weightType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil){ (query, results, error) in
            
            DispatchQueue.main.async{
                guard let result = results?.last as? HKQuantitySample else{
                    self.weight = String(Int(0))
                    return
                }
                self.weight = String(result.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo)))
            }
            
        }
        healthStore.execute(query)
    }
    
    func getTodayHeight(){
        guard let heightType = HKObjectType.quantityType(forIdentifier: .height) else{
            print("Error: identifier .height")
            return
        }
        observerQuery = HKObserverQuery(sampleType: heightType, predicate: nil, updateHandler: { query, completionHandler, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.getHeightData()
        })
        observerQuery.map(healthStore.execute)
    }
    
    private func getHeightData(){
        let heightType = HKQuantityType(.height)
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: heightType,
                                  predicate: predicate,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil){ (query, results, error) in
            DispatchQueue.main.async{
                guard let result = results?.last as? HKQuantitySample else{
                    self.height = String(Int(0))
                    return
                }
                self.height = String(result.quantity.doubleValue(for: HKUnit.meterUnit(with: .centi)))
            }
            
        }
        healthStore.execute(query)
    }

}
