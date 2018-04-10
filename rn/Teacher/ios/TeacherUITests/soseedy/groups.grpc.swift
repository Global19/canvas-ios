//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: groups.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Foundation
import Dispatch
import SwiftGRPC
import SwiftProtobuf

internal protocol Soseedy_SeedyGroupsCreateCourseGroupCategoryCall: ClientCallUnary {}

fileprivate final class Soseedy_SeedyGroupsCreateCourseGroupCategoryCallBase: ClientCallUnaryBase<Soseedy_CreateCourseGroupCategoryRequest, Soseedy_GroupCategory>, Soseedy_SeedyGroupsCreateCourseGroupCategoryCall {
  override class var method: String { return "/soseedy.SeedyGroups/CreateCourseGroupCategory" }
}

internal protocol Soseedy_SeedyGroupsCreateGroupCall: ClientCallUnary {}

fileprivate final class Soseedy_SeedyGroupsCreateGroupCallBase: ClientCallUnaryBase<Soseedy_CreateGroupRequest, Soseedy_Group>, Soseedy_SeedyGroupsCreateGroupCall {
  override class var method: String { return "/soseedy.SeedyGroups/CreateGroup" }
}

internal protocol Soseedy_SeedyGroupsCreateGroupMembershipCall: ClientCallUnary {}

fileprivate final class Soseedy_SeedyGroupsCreateGroupMembershipCallBase: ClientCallUnaryBase<Soseedy_CreateGroupMembershipRequest, Soseedy_GroupMembership>, Soseedy_SeedyGroupsCreateGroupMembershipCall {
  override class var method: String { return "/soseedy.SeedyGroups/CreateGroupMembership" }
}


/// Instantiate Soseedy_SeedyGroupsServiceClient, then call methods of this protocol to make API calls.
internal protocol Soseedy_SeedyGroupsService: ServiceClient {
  /// Synchronous. Unary.
  func createCourseGroupCategory(_ request: Soseedy_CreateCourseGroupCategoryRequest) throws -> Soseedy_GroupCategory
  /// Asynchronous. Unary.
  func createCourseGroupCategory(_ request: Soseedy_CreateCourseGroupCategoryRequest, completion: @escaping (Soseedy_GroupCategory?, CallResult) -> Void) throws -> Soseedy_SeedyGroupsCreateCourseGroupCategoryCall

  /// Synchronous. Unary.
  func createGroup(_ request: Soseedy_CreateGroupRequest) throws -> Soseedy_Group
  /// Asynchronous. Unary.
  func createGroup(_ request: Soseedy_CreateGroupRequest, completion: @escaping (Soseedy_Group?, CallResult) -> Void) throws -> Soseedy_SeedyGroupsCreateGroupCall

  /// Synchronous. Unary.
  func createGroupMembership(_ request: Soseedy_CreateGroupMembershipRequest) throws -> Soseedy_GroupMembership
  /// Asynchronous. Unary.
  func createGroupMembership(_ request: Soseedy_CreateGroupMembershipRequest, completion: @escaping (Soseedy_GroupMembership?, CallResult) -> Void) throws -> Soseedy_SeedyGroupsCreateGroupMembershipCall

}

internal final class Soseedy_SeedyGroupsServiceClient: ServiceClientBase, Soseedy_SeedyGroupsService {
  /// Synchronous. Unary.
  internal func createCourseGroupCategory(_ request: Soseedy_CreateCourseGroupCategoryRequest) throws -> Soseedy_GroupCategory {
    return try Soseedy_SeedyGroupsCreateCourseGroupCategoryCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func createCourseGroupCategory(_ request: Soseedy_CreateCourseGroupCategoryRequest, completion: @escaping (Soseedy_GroupCategory?, CallResult) -> Void) throws -> Soseedy_SeedyGroupsCreateCourseGroupCategoryCall {
    return try Soseedy_SeedyGroupsCreateCourseGroupCategoryCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func createGroup(_ request: Soseedy_CreateGroupRequest) throws -> Soseedy_Group {
    return try Soseedy_SeedyGroupsCreateGroupCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func createGroup(_ request: Soseedy_CreateGroupRequest, completion: @escaping (Soseedy_Group?, CallResult) -> Void) throws -> Soseedy_SeedyGroupsCreateGroupCall {
    return try Soseedy_SeedyGroupsCreateGroupCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func createGroupMembership(_ request: Soseedy_CreateGroupMembershipRequest) throws -> Soseedy_GroupMembership {
    return try Soseedy_SeedyGroupsCreateGroupMembershipCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func createGroupMembership(_ request: Soseedy_CreateGroupMembershipRequest, completion: @escaping (Soseedy_GroupMembership?, CallResult) -> Void) throws -> Soseedy_SeedyGroupsCreateGroupMembershipCall {
    return try Soseedy_SeedyGroupsCreateGroupMembershipCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Soseedy_SeedyGroupsProvider {
  func createCourseGroupCategory(request: Soseedy_CreateCourseGroupCategoryRequest, session: Soseedy_SeedyGroupsCreateCourseGroupCategorySession) throws -> Soseedy_GroupCategory
  func createGroup(request: Soseedy_CreateGroupRequest, session: Soseedy_SeedyGroupsCreateGroupSession) throws -> Soseedy_Group
  func createGroupMembership(request: Soseedy_CreateGroupMembershipRequest, session: Soseedy_SeedyGroupsCreateGroupMembershipSession) throws -> Soseedy_GroupMembership
}

internal protocol Soseedy_SeedyGroupsCreateCourseGroupCategorySession: ServerSessionUnary {}

fileprivate final class Soseedy_SeedyGroupsCreateCourseGroupCategorySessionBase: ServerSessionUnaryBase<Soseedy_CreateCourseGroupCategoryRequest, Soseedy_GroupCategory>, Soseedy_SeedyGroupsCreateCourseGroupCategorySession {}

internal protocol Soseedy_SeedyGroupsCreateGroupSession: ServerSessionUnary {}

fileprivate final class Soseedy_SeedyGroupsCreateGroupSessionBase: ServerSessionUnaryBase<Soseedy_CreateGroupRequest, Soseedy_Group>, Soseedy_SeedyGroupsCreateGroupSession {}

internal protocol Soseedy_SeedyGroupsCreateGroupMembershipSession: ServerSessionUnary {}

fileprivate final class Soseedy_SeedyGroupsCreateGroupMembershipSessionBase: ServerSessionUnaryBase<Soseedy_CreateGroupMembershipRequest, Soseedy_GroupMembership>, Soseedy_SeedyGroupsCreateGroupMembershipSession {}


/// Main server for generated service
internal final class Soseedy_SeedyGroupsServer: ServiceServer {
  private let provider: Soseedy_SeedyGroupsProvider

  internal init(address: String, provider: Soseedy_SeedyGroupsProvider) {
    self.provider = provider
    super.init(address: address)
  }

  internal init?(address: String, certificateURL: URL, keyURL: URL, provider: Soseedy_SeedyGroupsProvider) {
    self.provider = provider
    super.init(address: address, certificateURL: certificateURL, keyURL: keyURL)
  }

  internal init?(address: String, certificateString: String, keyString: String, provider: Soseedy_SeedyGroupsProvider) {
    self.provider = provider
    super.init(address: address, certificateString: certificateString, keyString: keyString)
  }

  /// Start the server.
  internal override func handleMethod(_ method: String, handler: Handler, queue: DispatchQueue) throws -> Bool {
    let provider = self.provider
    switch method {
    case "/soseedy.SeedyGroups/CreateCourseGroupCategory":
      try Soseedy_SeedyGroupsCreateCourseGroupCategorySessionBase(
        handler: handler,
        providerBlock: { try provider.createCourseGroupCategory(request: $0, session: $1 as! Soseedy_SeedyGroupsCreateCourseGroupCategorySessionBase) })
          .run(queue: queue)
      return true
    case "/soseedy.SeedyGroups/CreateGroup":
      try Soseedy_SeedyGroupsCreateGroupSessionBase(
        handler: handler,
        providerBlock: { try provider.createGroup(request: $0, session: $1 as! Soseedy_SeedyGroupsCreateGroupSessionBase) })
          .run(queue: queue)
      return true
    case "/soseedy.SeedyGroups/CreateGroupMembership":
      try Soseedy_SeedyGroupsCreateGroupMembershipSessionBase(
        handler: handler,
        providerBlock: { try provider.createGroupMembership(request: $0, session: $1 as! Soseedy_SeedyGroupsCreateGroupMembershipSessionBase) })
          .run(queue: queue)
      return true
    default:
      return false
    }
  }
}

