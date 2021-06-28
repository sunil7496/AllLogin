//
//  AppleSignInViewController.swift
//  Demo
//
//  Created by TrivialWorks on 23/12/19.
//  Copyright © 2019 TrivialWorks. All rights reserved.
//

import UIKit
import AuthenticationServices
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import FirebaseAuth
import TwitterKit
import TwitterCore

class AppleSignInViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var appleSignInBtn: UIButton!
    @IBOutlet weak var fbSignInBtn: UIButton!
    @IBOutlet weak var googlePlusSignInBtn: UIButton!
    @IBOutlet weak var whatappBtn: UIButton!
    @IBOutlet weak var twitterSignInBtn: UIButton!
    var userEmail = ""
    var userName = ""
    var socialType = ""
    var provider = OAuthProvider(providerID: "twitter.com")
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        appleSignInBtn.isHidden = true
//        fbSignInBtn.isHidden = true
//        googlePlusSignInBtn.isHidden = true
//        whatappBtn.isHidden = true
        
        appleSignInBtn.layer.cornerRadius = 20
        fbSignInBtn.layer.cornerRadius = 20
        googlePlusSignInBtn.layer.cornerRadius = 20
        whatappBtn.layer.cornerRadius = 20
        twitterSignInBtn.layer.cornerRadius = 20
        
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
    }

    //MARK:- Button Action
    @IBAction func appleSigninBtnAction(_ sender: UIButton) {
        actionHandleAppleSignin()
    }
    
    @IBAction func fbSignInBtnAction(_ sender: UIButton) {
        loginWithFacebook()
    }
    
    @IBAction func googlePlusBtnAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func whatsappBtnAction(_ sender: UIButton) {
        let phoneNumber =  "919455555555" // you need to change this number
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        } else {
            let appURL = URL(string: "https://api.whatsapp.com/")!
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func twitterSignInBtnAcrtion(_ sender: Any)
    {
       TWTRTwitter.sharedInstance().logIn { (session, error) in
            if (session != nil) {
                let client = TWTRAPIClient.withCurrentUser()
                client.requestEmail { email, error in
                    if (email != nil) {
                        print("signed in as \(String(describing: session?.userName))");
                        let firstName = session?.userName ?? ""   // received first name
                        let lastName = session?.userName ?? ""  // received last name
                        let recivedEmailID = email ?? ""   // received email
                        
                        print("\(firstName)" + " \(lastName)" + " \(recivedEmailID)")
                        
                        self.userName = firstName + " " + lastName
                        self.userEmail = recivedEmailID
                        self.socialType = "Twitter Login"
                        self.NavigateAfterResult()
                    }else {
                        print("error: \(String(describing: error?.localizedDescription))");
                    }
                }
            }else {
                print("error: \(String(describing: error?.localizedDescription))");
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
       return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }

    func actionHandleAppleSignin() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func NavigateAfterResult(){
        let vc = SuccessViewController()
        vc.userEmail = userEmail
        vc.userName = userName
        vc.socialType = socialType
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Extention- Apple Login
 @available(iOS 13.0, *)
extension AppleSignInViewController: ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
   
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization)
    {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential
        {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
            
            userEmail = email ?? userIdentifier
            userName = appleIDCredential.fullName?.givenName ?? ""
            socialType = "Apple Login"
            NavigateAfterResult()
            
        }
        else if let passwordCredential = authorization.credential as? ASPasswordCredential
        {
            _ = passwordCredential.user
            _ = passwordCredential.password
            //Write your code
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor
    {
        return self.view.window!
    }
}

//MARK:- Extention Google SignIn
extension AppleSignInViewController : GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
    {
        if (error == nil)
        {
            print(user.profile!)
            UserDefaults.standard.set(user.profile.name, forKey: "Name")
            UserDefaults.standard.set(user.profile.email, forKey: "Email")
            UserDefaults.standard.set(user.userID, forKey: "socialId")
            UserDefaults.standard.set(String(describing: user.profile.imageURL(withDimension: 120)!), forKey: "pictureURL")
            
            self.userName = (user?.profile.name ?? "")
            self.userEmail = (user?.profile.email ?? "")
            self.socialType = "Google Plus"
            self.NavigateAfterResult()
        }
        else
        {
            print("\(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- Extention Facebook SignIn
extension AppleSignInViewController{
    func loginWithFacebook() {
            LoginManager().logOut()
            let fbLoginManager : LoginManager = LoginManager()
            fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
                if (error == nil)
                {
                    let fbloginresult : LoginManagerLoginResult = result!
                    if (result?.isCancelled)!
                    {
                        return
                    }
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                    }
                }
            }
        }
    
    func getFBUserData()
    {
        if((AccessToken.current) != nil)
        {
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil)
                {
                    let  postData = result as! NSDictionary
                    print(postData)
                    UserDefaults.standard.set(postData.object(forKey: "name") as! String, forKey: "Name")
                    UserDefaults.standard.set(postData.object(forKey: "email") as! String, forKey: "Email")
                    UserDefaults.standard.set(postData.object(forKey: "id") as! String, forKey: "socialId")
                    let picDic = postData.object(forKey: "picture") as! NSDictionary
                    let dataDic = picDic.object(forKey: "data") as! NSDictionary
                    let url = dataDic.object(forKey: "url") as! String
                    UserDefaults.standard.set(url, forKey: "pictureURL")

                    self.userName = postData.object(forKey: "name") as! String
                    self.userEmail = postData.object(forKey: "email") as! String
                    self.socialType = "Facebook"
                    self.NavigateAfterResult()
                }
            })
        }
    }
}

