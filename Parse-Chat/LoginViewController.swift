//
//  LoginViewController.swift
//  Parse-Chat
//
//  Created by Aarnav Ram on 23/02/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginPressed(_ sender: AnyObject) {
        if let emailTextField = emailTextField {
            if emailTextField.text! != "" {
                if let passwordTextField = passwordTextField {
                    if passwordTextField.text! == "" {
                        //alertMessage(string: "Please enter a password")
                    } else {
                        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user: PFUser?, error: Error?) in
                            print(user?.username!)
                            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                        })
                    }
                }
                print(emailTextField.text!)
            } else {
                //alertMessage(string: "Please enter an email address")
                if let passwordTextField = passwordTextField {
                    if passwordTextField.text! != "" {
                        //alertMessage(string: "Please enter a password")
                    }
                    
                }
                
            }
        }
    }
    
    @IBAction func onSignUpPressed(_ sender: AnyObject) {
        print("Reached here")

        var user = PFUser()
        
        if let emailTextField = emailTextField {
            if emailTextField.text! != "" {
                if let passwordTextField = passwordTextField {
                    if passwordTextField.text! == "" {
                        alertMessage(title: "Missing",string: "Please enter a password")
                    } else {
                        user.username = emailTextField.text!
                        user.password = passwordTextField.text!
                        
                        user.signUpInBackground(block: { (succeeded: Bool, error: Error?) in
                            if let error = error {
                                print(error)
                            } else {
                                self.alertMessage(title: "Congratulations",string: "now Login")
                            }
                        })
                    }
                }
                print(emailTextField.text!)
            } else {
                alertMessage(title: "Missing", string: "Please enter an email address")
                if let passwordTextField = passwordTextField {
                    if passwordTextField.text! != "" {
                        alertMessage(title: "Missing",string: "Please enter a password")
                    }
                    
                }

            }
        }
        
    }
    
    func alertMessage(title:String, string: String) {
        let alertController = UIAlertController(title: title, message: string, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            //dismiss it
        }
        alertController.addAction(OKAction)
        present(alertController, animated: true) {
            //dismiss it
        }
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
