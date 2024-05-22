//
//  validation.swift
//  taskonesql
//
//  Created by MANSVITA on 31/08/22.
//

import Foundation
import UIKit
class Validation {
public func firstname(firstname: String) ->Bool {
     // Length be 18 characters max and 3 characters minimum, you can always modify.
     let nameRegex = "[A-Za-z0-9]{5,20}"
     let trimmedString = firstname.trimmingCharacters(in: .whitespaces)
     let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
     let isValidateName = validateName.evaluate(with: trimmedString)
     return isValidateName
  }
    public func lastname(lastname: String) ->Bool {
      // Length be 18 characters max and 3 characters minimum, you can always modify.
      let nameRegex = "[A-Za-z0-9]{5,20}"
      let trimmedString = lastname.trimmingCharacters(in: .whitespaces)
      let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
      let isValidateName = validateName.evaluate(with: trimmedString)
      return isValidateName
   }
  public func Phoneno(phoneno: String) -> Bool {
     let phoneNumberRegex = "[0-9]{10}"
     let trimmedString = phoneno.trimmingCharacters(in: .whitespaces)
     let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
     let isValidPhone = validatePhone.evaluate(with: trimmedString)
     return isValidPhone
  }
  public func email(email: String) -> Bool {
     let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
     let trimmedString = email.trimmingCharacters(in: .whitespaces)
     let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
     let isValidateEmail = validateEmail.evaluate(with: trimmedString)
     return isValidateEmail
  }
    public func address(address: String) -> Bool {
       let emailRegEx = "[A-Za-z0-9]{5,20}"
       let trimmedString = address.trimmingCharacters(in: .whitespaces)
       let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       let isValidateEmail = validateEmail.evaluate(with: trimmedString)
       return isValidateEmail
    }
 

  }


