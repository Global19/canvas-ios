//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: files.proto
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

internal protocol Soseedy_SeedyFilesUploadFileCall: ClientCallUnary {}

fileprivate final class Soseedy_SeedyFilesUploadFileCallBase: ClientCallUnaryBase<Soseedy_UploadFileRequest, Soseedy_Attachment>, Soseedy_SeedyFilesUploadFileCall {
  override class var method: String { return "/soseedy.SeedyFiles/UploadFile" }
}


/// Instantiate Soseedy_SeedyFilesServiceClient, then call methods of this protocol to make API calls.
internal protocol Soseedy_SeedyFilesService: ServiceClient {
  /// Synchronous. Unary.
  func uploadFile(_ request: Soseedy_UploadFileRequest) throws -> Soseedy_Attachment
  /// Asynchronous. Unary.
  func uploadFile(_ request: Soseedy_UploadFileRequest, completion: @escaping (Soseedy_Attachment?, CallResult) -> Void) throws -> Soseedy_SeedyFilesUploadFileCall

}

internal final class Soseedy_SeedyFilesServiceClient: ServiceClientBase, Soseedy_SeedyFilesService {
  /// Synchronous. Unary.
  internal func uploadFile(_ request: Soseedy_UploadFileRequest) throws -> Soseedy_Attachment {
    return try Soseedy_SeedyFilesUploadFileCallBase(channel)
      .run(request: request, metadata: metadata)
  }
  /// Asynchronous. Unary.
  internal func uploadFile(_ request: Soseedy_UploadFileRequest, completion: @escaping (Soseedy_Attachment?, CallResult) -> Void) throws -> Soseedy_SeedyFilesUploadFileCall {
    return try Soseedy_SeedyFilesUploadFileCallBase(channel)
      .start(request: request, metadata: metadata, completion: completion)
  }

}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Soseedy_SeedyFilesProvider {
  func uploadFile(request: Soseedy_UploadFileRequest, session: Soseedy_SeedyFilesUploadFileSession) throws -> Soseedy_Attachment
}

internal protocol Soseedy_SeedyFilesUploadFileSession: ServerSessionUnary {}

fileprivate final class Soseedy_SeedyFilesUploadFileSessionBase: ServerSessionUnaryBase<Soseedy_UploadFileRequest, Soseedy_Attachment>, Soseedy_SeedyFilesUploadFileSession {}


/// Main server for generated service
internal final class Soseedy_SeedyFilesServer: ServiceServer {
  private let provider: Soseedy_SeedyFilesProvider

  internal init(address: String, provider: Soseedy_SeedyFilesProvider) {
    self.provider = provider
    super.init(address: address)
  }

  internal init?(address: String, certificateURL: URL, keyURL: URL, provider: Soseedy_SeedyFilesProvider) {
    self.provider = provider
    super.init(address: address, certificateURL: certificateURL, keyURL: keyURL)
  }

  internal init?(address: String, certificateString: String, keyString: String, provider: Soseedy_SeedyFilesProvider) {
    self.provider = provider
    super.init(address: address, certificateString: certificateString, keyString: keyString)
  }

  /// Start the server.
  internal override func handleMethod(_ method: String, handler: Handler, queue: DispatchQueue) throws -> Bool {
    let provider = self.provider
    switch method {
    case "/soseedy.SeedyFiles/UploadFile":
      try Soseedy_SeedyFilesUploadFileSessionBase(
        handler: handler,
        providerBlock: { try provider.uploadFile(request: $0, session: $1 as! Soseedy_SeedyFilesUploadFileSessionBase) })
          .run(queue: queue)
      return true
    default:
      return false
    }
  }
}

