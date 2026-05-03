//
//  JDApex_PredatorsTests.swift
//  JDApex_PredatorsTests
//
//  Created by Jyotsna Daiyya on 03/05/26.
//

import Testing
@testable import JDApex_Predators

struct JDApex_PredatorsTests {

    @Test func testIconName() async throws {
       
        let ts = APType.air
        assert(ts.iconName.elementsEqual("wind"))
        
    }

}
