//
//  Account.swift
//  CreateAccount
//
//  Created by Marco Willems on 09/12/15.
//  Copyright © 2015 ExtremaHeroes. All rights reserved.
//

import Foundation

public class Account{
    private var firstname : String!
    private var lastname : String!
    private var email : String!
    
    public static var accounts : [Account] = []
    
    init(firstname: String, lastname : String, email: String){
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
    }
    public static func createAccount(firstname: String, lastname : String, email: String, password: String){
        
    }
    
    public static func getDemoAccounts() -> [Account]{
        var tempAccounts : [Account] = []
        var account1 = Account(firstname: "Marco", lastname: "Willems", email: "mail@marcowillems.nl")
        var account2 = Account(firstname: "Jense", lastname: "Schounte", email: "jense@schouten.nl")
        
        tempAccounts.append(account1)
        tempAccounts.append(account2)
        
        return tempAccounts
    }
    
    public static func checkIfEmailInUse(email : String) ->Bool {
        for account in self.accounts {
            if (account.email == email) {
                return true
            }
        }
        return false
    }
}