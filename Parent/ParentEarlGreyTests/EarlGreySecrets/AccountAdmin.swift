//
// Copyright (C) 2016-present Instructure, Inc.
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

// This is an autogenerated file.

// swiftlint:disable type_body_length
// swiftlint:disable file_length

class AccountAdmin {
    // MARK: - Canvas Domain
    static let domain: String = "twilson.test.instructure.com"
}

extension Course {
    // MARK: - Courses
    static var coursesTab: Course {
        return Course(id:         230,
                      name:       "Courses Tab",
                      courseCode: "CT",
                      accountId:  1)
    }

}

extension CanvasUser {
    // MARK: - Teachers

    // MARK: - Students
    static var withNoCoursesSettingsPage: CanvasUser {
        return CanvasUser(id:       897,
                          domain:   "twilson.test.instructure.com",
                          loginId:  "withNoCoursesSettingsPage@i.com",
                          password: "6qnj77jfeW7sWuWB",
                          name:     "withNoCoursesSettingsPage@i.com")
    }

    static var withNoCoursesDashboardPage: CanvasUser {
        return CanvasUser(id:       898,
                          domain:   "twilson.test.instructure.com",
                          loginId:  "withNoCoursesDashboardPage@i.com",
                          password: "j6vH93MDaz8LbHnW",
                          name:     "withNoCoursesDashboardPage@i.com")
    }

    static var withNoCoursesCoursesTabPage: CanvasUser {
        return CanvasUser(id:       899,
                          domain:   "twilson.test.instructure.com",
                          loginId:  "withNoCoursesCoursesTabPage@i.com",
                          password: "PaEfTMz7Bj8PGx9E",
                          name:     "withNoCoursesCoursesTabPage@i.com")
    }

    static var withOneCourseCoursesTabPage: CanvasUser {
        return CanvasUser(id:       900,
                          domain:   "twilson.test.instructure.com",
                          loginId:  "withOneCourseCoursesTabPage@i.com",
                          password: "Y6GX9HGgFJdxYEFz",
                          name:     "withOneCourseCoursesTabPage@i.com")
    }

    static var withNoCoursesWeekTabPage: CanvasUser {
        return CanvasUser(id:       901,
                          domain:   "twilson.test.instructure.com",
                          loginId:  "withNoCoursesWeekTabPage@i.com",
                          password: "CA5fhtpzpssYMGd4",
                          name:     "withNoCoursesWeekTabPage@i.com")
    }

    static var withNoCoursesAlertsTabPage: CanvasUser {
        return CanvasUser(id:       902,
                          domain:   "twilson.test.instructure.com",
                          loginId:  "withNoCoursesAlertsTabPage@i.com",
                          password: "52RAMu5LGHwr3gh6",
                          name:     "withNoCoursesAlertsTabPage@i.com")
    }

}

extension Enrollment {
    // MARK: - Enrollments
    static var enrollments: [Enrollment] {
        return [Enrollment(id:              882,
                           courseId:        230,
                           userId:          900,
                           enrollmentState: "active",
                           type:            "StudentEnrollment")]
    }
}

extension Assignment {
    // MARK: - Assignments
}

extension Page {
    // MARK: - Pages
}

extension Quiz {
    // MARK: - Quizzes
}

extension CanvasParent {
    // MARK: - Parents
    static var withNoStudentsDomainPickerPage: CanvasParent {
        return CanvasParent(parentId:   "10980956-26e0-422e-a597-1774c3351a4c",
                            username:   "withNoStudentsDomainPickerPage@i.com",
                            password:   "EaaUB6xEsY76cAm4",
                            firstName:  "Parent",
                            lastName:   "WithNoStudents",
                            students:   [],
                            thresholds: [],
                            alerts:     [])
    }

    static var whoForgotPasswordPage: CanvasParent {
        return CanvasParent(parentId:   "a71f5ad2-7d20-42b4-aefa-a9ec8744e33b",
                            username:   "whoForgotPasswordPage@i.com",
                            password:   "ByGramWq2Wwa6Vtu",
                            firstName:  "Parent",
                            lastName:   "ForgotPassword",
                            students:   [],
                            thresholds: [],
                            alerts:     [])
    }

    static var withNoStudentsGettingStartedPage: CanvasParent {
        return CanvasParent(parentId:   "c71becab-32b1-4d79-af90-7ebe35cd55e4",
                            username:   "withNoStudentsGettingStartedPage@i.com",
                            password:   "6JWWcf7R23tdLtga",
                            firstName:  "Parent",
                            lastName:   "WithNoStudents",
                            students:   [],
                            thresholds: [],
                            alerts:     [])
    }

    static var withOneStudentSettingsPage: CanvasParent {
        return CanvasParent(parentId:   "02ad0ca9-d185-4496-b145-7085a4f36391",
                            username:   "withOneStudentSettingsPage@i.com",
                            password:   "8AKvcYEPA7cWXbVV",
                            firstName:  "Parent",
                            lastName:   "WithOneStudent",
                            students:   [CanvasUser.withNoCoursesSettingsPage],
                            thresholds: [],
                            alerts:     [])
    }

    static var withOneStudentDashboardPage: CanvasParent {
        return CanvasParent(parentId:   "fed7013d-ae91-4609-a4b8-034c8c244348",
                            username:   "withOneStudentDashboardPage@i.com",
                            password:   "BJdmNbEK6QzPZ2dM",
                            firstName:  "Parent",
                            lastName:   "WithOneStudent",
                            students:   [CanvasUser.withNoCoursesDashboardPage],
                            thresholds: [],
                            alerts:     [])
    }

    static var withStudentWithNoCoursesCoursesTabPage: CanvasParent {
        return CanvasParent(parentId:   "43b736e0-d453-41f7-8b38-2801e98d7c53",
                            username:   "withStudentWithNoCoursesCoursesTabPage@i.com",
                            password:   "qGAg9qwpzC2pzQX3",
                            firstName:  "Parent",
                            lastName:   "WithStudentWithNoCourses",
                            students:   [CanvasUser.withNoCoursesCoursesTabPage],
                            thresholds: [],
                            alerts:     [])
    }

    static var withStudentWithOneCourseCoursesTabPage: CanvasParent {
        return CanvasParent(parentId:   "e4831801-03d5-4a31-8fe4-58c27bf052d1",
                            username:   "withStudentWithOneCourseCoursesTabPage@i.com",
                            password:   "tp8RQzAhWspxmwkE",
                            firstName:  "Parent",
                            lastName:   "WithStudentWithOneCourses",
                            students:   [CanvasUser.withOneCourseCoursesTabPage],
                            thresholds: [],
                            alerts:     [])
    }

    static var withStudentWithNoCoursesWeekTabPage: CanvasParent {
        return CanvasParent(parentId:   "fee7ae76-d50c-4400-b90e-153bb2fb2435",
                            username:   "withStudentWithNoCoursesWeekTabPage@i.com",
                            password:   "TZynrYF26R2C2AaV",
                            firstName:  "Parent",
                            lastName:   "WithStudentWithNoCourses",
                            students:   [CanvasUser.withNoCoursesWeekTabPage],
                            thresholds: [],
                            alerts:     [])
    }

    static var withStudentWithNoCoursesAlertsTabPage: CanvasParent {
        return CanvasParent(parentId:   "4bb8d428-b874-45d9-a60e-8430be69c6bb",
                            username:   "withStudentWithNoCoursesAlertsTabPage@i.com",
                            password:   "krmvUJ2B7TkcC4yb",
                            firstName:  "Parent",
                            lastName:   "WithStudentWithNoCourses",
                            students:   [CanvasUser.withNoCoursesAlertsTabPage],
                            thresholds: [],
                            alerts:     [])
    }

}
