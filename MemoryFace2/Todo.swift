//
//  Todo.swift
//  MemoryFace2
//
//  Created by 福井　愛梨 on 2019/12/07.
//  Copyright © 2019 福井　愛梨. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class Obj: Object{
     @objc dynamic var textFieldString: String?
     @objc dynamic var hint1: String?
     @objc dynamic var hint2: String?
     @objc dynamic var pictureurl: String?
}
