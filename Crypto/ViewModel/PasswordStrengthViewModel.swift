//
//  PasswordStrengthViewModel.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class PasswordStrengthViewModel: ObservableObject {
    @Published var password: String = ""
    @Published var passwordStrength: PasswordStrength = .weak
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $password
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] password in
                guard let weakSelf = self else { return }
                weakSelf.passwordStrength = weakSelf.computeStrength(password)
            }
            .store(in: &cancellables)
    }
    
    func computeStrength(_ password: String) -> PasswordStrength {
        let lengthRequirement = password.count >= 8
        let specialCharCount = password.filter { !$0.isLetter && !$0.isNumber }.count
        let uppercaseCount = password.filter { $0.isUppercase }.count
        let numericCount = password.filter { $0.isNumber }.count
        
        if lengthRequirement {
            if specialCharCount >= 2 && uppercaseCount >= 1 && numericCount >= 2 {
                return .strong
            } else if (specialCharCount >= 1 || uppercaseCount >= 1) && numericCount >= 1 {
                return .good
            } else {
                return .fair
            }
        } else {
            return .weak
        }
    }
}
