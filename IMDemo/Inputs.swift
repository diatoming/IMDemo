//
//  Inputs.swift
//  IMDemo
//
//  Created by Jeff Leung on 15/8/26.
//  Copyright © 2015年 Jeff Leung. All rights reserved.
//

import Foundation

struct Inputs: OptionSetType   {
    let rawValue: Int
    static let user = Inputs(rawValue: 1)  //1
    static let password = Inputs(rawValue: 1 << 1)   //10
    static let mail = Inputs(rawValue: 1 << 2)    //100
    
}

//判断是否全部输入
extension Inputs{
    mutating func isAllOK() -> Bool {

//选项的数目
   let count = 3

//找到的数目
   var found = 0

//在数目范围内查找，若找到，次数增加

        for time in 0..<count where contains(Inputs(rawValue: 1 << time)) {
            found++
}

//比较次数与选项的的数目
  return found == count
}
    
}

extension Inputs:BooleanType {
    var boolValue: Bool {
        return self.rawValue == 0b111
    }
    
}

//let possibleInputs: Inputs = [.user, .password, .mail]
//  possibleInputs.isAllOK()
//
// if possibleInputs{
//    print("OK")
//}
