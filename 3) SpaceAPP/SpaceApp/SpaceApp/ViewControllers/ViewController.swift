import UIKit
import AVFoundation
import UserNotifications
class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var img = UIImage()
    
    @IBAction func photo(_ sender: Any) {
        checkCameraPermissions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func informationBT() {
        
        let alert = UIAlertController(title: "Kind of fire.", message: "Please select what kind of fire do you want to get information about", preferredStyle: .actionSheet)
        let urban = UIAlertAction(title: "Urban", style: .default) { (action) in
            self.performSegue(withIdentifier: "urbanSG", sender: nil)
        }
        let forest = UIAlertAction(title: "Forest fire", style: .default) { (action) in
            self.performSegue(withIdentifier: "forestSG", sender: nil)
        }
        alert.addAction(urban)
        alert.addAction(forest)
        present(alert, animated: false, completion: nil)
        
    }
    private func checkCameraPermissions() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            print("1")
            presentPicker()
        case.notDetermined:
            print("2")
            askPermision()
        case .denied:
            print("3")
            // user denied access
            self.permissionDenied()
        case .restricted:
            print("Error restricted")
        }
    }
    @IBAction func fireNotification() {
        let center = UNUserNotificationCenter.current()
         var content = UNMutableNotificationContent()
        content.title = "Warn of fire"
        content.body = "We have identified a fire near you, be careful"
        content.sound = UNNotificationSound.defaultCritical
        content.threadIdentifier = "FireHazard"
         let date = Date(timeIntervalSinceNow: 1)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        
        center.add(request) { (error) in
            if error != nil{
                print ("error")
            }
            
        }
    }
    
    private func presentPicker() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            //            img.contentMode = .scaleToFill
            img = pickedImage
        }
        self.dismiss(animated: true){
            self.performSegue(withIdentifier: "captured", sender: nil)
        }
        
    }
    
    private func askPermision(){
        AVCaptureDevice.requestAccess(for: AVMediaType.video) {granted in
            if granted {
                self.presentPicker()
            } else {
                print("Denied")
            }
        }
    }
    
    private func permissionDenied() {
        let alert = UIAlertController(title: "Access to camera is denied", message: "You have denied the access to the camera. Would you like to able it?", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            self.askPermision()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel")
        }
        alert.addAction(actionOK)
        alert.addAction(cancel)
        present(alert, animated : true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "captured"){
            let vc = segue.destination as! ImageReportedVC
            vc.imgAux = img
        }
    }
}
