//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: user.proto
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

internal protocol Soseedy_SeedyUsersCreateCanvasUserCall: ClientCallUnary {}

fileprivate final class Soseedy_SeedyUsersCreateCanvasUserCallBase: ClientCallUnaryBase<Soseedy_CreateCanvasUserRequest, Soseedy_CanvasUser>, Soseedy_SeedyUsersCreateCanvasUserCall {
  override class var method: String { return "/soseedy.SeedyUsers/CreateCanvasUser" }
}


/// Instantiate Soseedy_SeedyUsersServiceClient, then call methods of this protocol to make API calls.
internal protocol Soseedy_SeedyUsersService: ServiceClient {
  /// Synchronous. Unary.
  func createCanvasUser(_ request: Soseedy_CreateCanvasUserRequest) throws -> Soseedy_CanvasUser
  /// Asynchronous. Unary.
  func createCanvasUser(_ request: Soseedy_CreateCanvasUserRequest, completion: @escaping (Soseedy_CanvasUser?, CallResult) -> Void) throws -> Soseedy_SeedyUsersCreateCanvasUserCall

}

internal final class Soseedy_SeedyUsersServiceClient: ServiceClientBase, Soseedy_SeedyUsersService {
  /// Synchronous. Unary.
  internal func createCanvasUser(_ request: Soseedy_CreateCanvasUserRequest) throws -> Soseedy_CanvasUser {
    return try Soseedy_SeedyUsersCreateCanvasUserCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func createCanvasUser(_ request: Soseedy_CreateCanvasUserRequest, completion: @escaping (Soseedy_CanvasUser?, CallResult) -> Void) throws -> Soseedy_SeedyUsersCreateCanvasUserCall {
    return try Soseedy_SeedyUsersCreateCanvasUserCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Soseedy_SeedyUsersProvider {
  func createCanvasUser(request: Soseedy_CreateCanvasUserRequest, session: Soseedy_SeedyUsersCreateCanvasUserSession) throws -> Soseedy_CanvasUser
}

internal protocol Soseedy_SeedyUsersCreateCanvasUserSession: ServerSessionUnary {}

fileprivate final class Soseedy_SeedyUsersCreateCanvasUserSessionBase: ServerSessionUnaryBase<Soseedy_CreateCanvasUserRequest, Soseedy_CanvasUser>, Soseedy_SeedyUsersCreateCanvasUserSession {}


/// Main server for generated service
internal final class Soseedy_SeedyUsersServer: ServiceServer {
  private let provider: Soseedy_SeedyUsersProvider

  internal init(address: String, provider: Soseedy_SeedyUsersProvider) {
    self.provider = provider
    super.init(address: address)
  }

  internal init?(address: String, certificateURL: URL, keyURL: URL, provider: Soseedy_SeedyUsersProvider) {
    self.provider = provider
    super.init(address: address, certificateURL: certificateURL, keyURL: keyURL)
  }

  internal init?(address: String, certificateString: String, keyString: String, provider: Soseedy_SeedyUsersProvider) {
    self.provider = provider
    super.init(address: address, certificateString: certificateString, keyString: keyString)
  }

  /// Start the server.
  internal override func handleMethod(_ method: String, handler: Handler, queue: DispatchQueue) throws -> Bool {
    let provider = self.provider
    switch method {
    case "/soseedy.SeedyUsers/CreateCanvasUser":
      try Soseedy_SeedyUsersCreateCanvasUserSessionBase(
        handler: handler,
        providerBlock: { try provider.createCanvasUser(request: $0, session: $1 as! Soseedy_SeedyUsersCreateCanvasUserSessionBase) })
          .run(queue: queue)
      return true
    default:
      return false
    }
  }
}

