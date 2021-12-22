import Foundation

extension LocalizedError {
  func asLocalizedNSError() -> NSError {
    let nsError = self as NSError
    var userInfo = nsError.userInfo
    userInfo[NSLocalizedDescriptionKey] = errorDescription
    userInfo[NSLocalizedFailureReasonErrorKey] = failureReason
    userInfo[NSLocalizedRecoverySuggestionErrorKey] = recoverySuggestion
    userInfo[NSHelpAnchorErrorKey] = helpAnchor

    return .init(
      domain: nsError.domain,
      code: nsError.code,
      userInfo: userInfo
    )
  }
}
