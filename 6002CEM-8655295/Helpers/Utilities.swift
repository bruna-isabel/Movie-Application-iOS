//
//  Utilities.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 06/04/2021.
//

import Foundation
class Utilities {
    

    static func passwordValidation(_ password: String) -> Bool {
    
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValid = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        
        return passwordValid.evaluate(with: password)
    }
    
    static func emailValidation(_ email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailValid = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailValid.evaluate(with: email)
    }

}
