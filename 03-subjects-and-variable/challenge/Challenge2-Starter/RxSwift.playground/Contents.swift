//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

example(of: "Variable") {

  enum UserSession {

    case loggedIn, loggedOut
  }

  enum LoginError: Error {

    case invalidCredentials
  }

  let disposeBag = DisposeBag()

  // Create userSession Variable of type UserSession with initial value of .loggedOut
  let sessionVariable = Variable<UserSession>(UserSession.loggedOut)


  // Subscribe to receive next events from userSession
    sessionVariable.asObservable().subscribe {
        print("Session event: ", $0)
    }
    .disposed(by: disposeBag)


  func logInWith(username: String, password: String, completion: (Error?) -> Void) {
    guard username == "johnny@appleseed.com",
      password == "appleseed"
      else {
        completion(LoginError.invalidCredentials)
        return
    }

    // Update userSession
    sessionVariable.value = UserSession.loggedIn

  }

  func logOut() {
    // Update userSession
    sessionVariable.value = UserSession.loggedOut

  }

  func performActionRequiringLoggedInUser(_ action: () -> Void) {
    // Ensure that userSession is loggedIn and then execute action()
    if sessionVariable.value == UserSession.loggedIn {
        action()
    }
  }

  for i in 1...2 {
    let password = i % 2 == 0 ? "appleseed" : "password"

    logInWith(username: "johnny@appleseed.com", password: password) { error in
      guard error == nil else {
        print(error!)
        return
      }

      print("User logged in.")
    }

    performActionRequiringLoggedInUser {
      print("Successfully did something only a logged in user can do.")
    }
  }
}
