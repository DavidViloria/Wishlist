//
//  Tip.swift
//  Wishlist
//
//  Created by David Viloria Ortega on 29/05/25.
//

import Foundation
import TipKit


struct ButtonTip: Tip {
    var title: Text = Text("Comida escensial")
    var message: Text? = Text("Agrega algunos articulos a tu lista diaria")
    var image: Image? = Image(systemName: "info.circle")
    
}
