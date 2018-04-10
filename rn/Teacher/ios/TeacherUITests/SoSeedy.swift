//
//  SoSeedy.swift
//  TeacherUITests
//
//  Created by Nathan Armstrong on 12/11/17.
//  Copyright © 2017 Instructure. All rights reserved.
//

import Foundation

let address = "localhost:50051"
let secure = false
let assignmentsClient = Soseedy_SeedyAssignmentsServiceClient(address: address, secure: secure)
let conversationsClient = Soseedy_SeedyConversationsServiceClient(address: address, secure: secure)
let coursesClient = Soseedy_SeedyCoursesServiceClient(address: address, secure: secure)
let discussionsClient = Soseedy_SeedyDiscussionsServiceClient(address: address, secure: secure)
let enrollmentsClient = Soseedy_SeedyEnrollmentsServiceClient(address: address, secure: secure)
let filesClient = Soseedy_SeedyFilesServiceClient(address: address, secure: secure)
let generalClient = Soseedy_SeedyGeneralServiceClient(address: address, secure: secure)
let gradingPeriodsClient = Soseedy_SeedyGradingPeriodsServiceClient(address: address, secure: secure)
let groupsClient = Soseedy_SeedyGroupsServiceClient(address: address, secure: secure)
let pagesClient = Soseedy_SeedyPagesServiceClient(address: address, secure: secure)
let quizzesClient = Soseedy_SeedyQuizzesServiceClient(address: address, secure: secure)
let sectionsClient = Soseedy_SeedySectionsServiceClient(address: address, secure: secure)
let usersClient = Soseedy_SeedyUsersServiceClient(address: address, secure: secure)

// MARK: - Enrollments

enum EnrollmentType: String {
    case teacher = "TeacherEnrollment"
}

@discardableResult func enroll(_ user: Soseedy_CanvasUser, as type: EnrollmentType, in course: Soseedy_Course) -> Soseedy_Enrollment {
    var enrollRequest = Soseedy_EnrollUserRequest()
    enrollRequest.courseID = course.id
    enrollRequest.userID = user.id
    enrollRequest.enrollmentType = type.rawValue
    return try! enrollmentsClient.enrollUserInCourse(enrollRequest)
}

func enroll(_ user: Soseedy_CanvasUser, as type: EnrollmentType, inAll courses: [Soseedy_Course]) -> [Soseedy_Enrollment] {
    return courses.map { enroll(user, as: type, in: $0) }
}

func createUser() -> Soseedy_CanvasUser {
    return try! usersClient.createCanvasUser(Soseedy_CreateCanvasUserRequest())
}

func createTeacher(in course: Soseedy_Course = createCourse()) -> Soseedy_CanvasUser {
    let user = createUser()
    enroll(user, as: .teacher, in: course)
    return user
}

func createTeacher(inAll courses: [Soseedy_Course]) -> Soseedy_CanvasUser {
    let user = createUser()
    courses.forEach { enroll(user, as: .teacher, in: $0) }
    return user
}

// MARK: - Courses

@discardableResult func createCourse() -> Soseedy_Course {
    return try! coursesClient.createCourse(Soseedy_CreateCourseRequest())
}

@discardableResult func favorite(_ course: Soseedy_Course, as user: Soseedy_CanvasUser) -> Soseedy_Favorite {
    var request = Soseedy_AddFavoriteCourseRequest()
    request.courseID = course.id
    request.token = user.token
    return try! coursesClient.addFavoriteCourse(request)
}

// MARK: - Assignments

enum SubmissionType: String {
    case none = "none"
    case onPaper = "on_paper"
    case onlineTextEntry = "online_text_entry"
    case onlineURL = "online_url"
    case onlineUpload = "online_upload"
}

func createAssignment(for course: Soseedy_Course = createCourse(), as teacher: Soseedy_CanvasUser, withDescription: Bool = false, submissionTypes: [Soseedy_SubmissionType] = []) -> Soseedy_Assignment {
    var request = Soseedy_CreateAssignmentRequest()
    request.courseID = course.id
    request.teacherToken = teacher.token
    request.withDescription = withDescription
    request.submissionTypes = submissionTypes
    return try! assignmentsClient.createAssignment(request)
}
