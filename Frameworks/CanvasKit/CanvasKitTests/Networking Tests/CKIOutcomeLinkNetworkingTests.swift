//
// Copyright (C) 2017-present Instructure, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import XCTest

class CKIOutcomeLinkNetworkingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFetchOutcomeLinksForOutcomeGroup() {
        let outcomeGroupDictionary = Helpers.loadJSONFixture("outcome_group") as NSDictionary
        let outcomeGroup = CKIOutcomeGroup(fromJSONDictionary: outcomeGroupDictionary)
        let client = MockCKIClient()
        
        client.fetchOutcomeLinksForOutcomeGroup(outcomeGroup)
        XCTAssertEqual(client.capturedPath!, "/api/v1/outcome_groups/1/outcomes", "CKIOutcomeLink returned API path for testFetchOutcomeLinksForOutcomeGroup was incorrect")
    }
}
