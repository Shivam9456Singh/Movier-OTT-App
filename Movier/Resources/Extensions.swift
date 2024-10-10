//
//  Extensions.swift
//  Movier
//
//  Created by Shivam Kumar on 15/08/24.
//

import Foundation

extension String {
    func capitalizeFirstLetter()-> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
