import Foundation

/// Resource protocol
protocol Resource {
  /**
   Determines the HTTPMethod requried based on the set case of a UserResource.

   - Returns: Correct HTTPMethod for the action required.
   */
  func getHTTPMethod() -> HTTPMethod

  /**
   Determines what to put in the request header.

   - Parameters:
   - email: User's email. Should match at least 1 document in the database.
   - password: User's password. Should match the user document's password.

   - Returns: A [String: String] of the request.
   */
  func getHeaders() -> [String: String]

  /**
   Determines what parameters the request will need based on the current case.
   */
  func getParams() -> [String: String]

  /**
   Converts the given param's in [String: String] format into a joined string.

   - Parameter parameters: [String: String] of parameters for an HTTP request.

   - Returns: The result of the input formatted as a useable string.
   */
  func stringFrom(_ parameters: [String: String]) -> String

  /**
   Determines which path the request needs.

   - Returns: A string of the desired path. ex: '\user\trips\'
   */
  func getPath() -> String

  /**
   Constructs an HTTP body out of the User codable object.

   - Returns: The json of the user object.
   */
  func getBody() -> Data?
}
