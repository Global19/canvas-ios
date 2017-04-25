/* @flow */

import { mapStateToProps, type AssignmentListProps } from '../map-state-to-props'

const template = {
  ...require('../../../api/canvas-api/__templates__/assignments'),
  ...require('../../../api/canvas-api/__templates__/course'),
  ...require('../../../api/canvas-api/__templates__/grading-periods'),
  ...require('../../../__templates__/react-native-navigation'),
  ...require('../../../redux/__templates__/app-state'),
}

test('map state to props should work', async () => {
  let course = template.course()
  let assignmentGroup = template.assignmentGroup()
  let assignment = template.assignment()
  let gradingPeriod = template.gradingPeriod({ id: 1 })
  let gradingPeriodTwo = template.gradingPeriod({ id: 2 })

  let state = template.appState({
    entities: {
      courses: {
        [course.id]: {
          assignmentGroups: { refs: [assignmentGroup.id] },
          course: course,
          color: 'blueish',
        },
      },
      assignmentGroups: {
        [assignmentGroup.id]: { group: assignmentGroup, assignmentRefs: [assignment.id] },
      },
      assignments: {
        [assignment.id]: { data: assignment },
      },
      gradingPeriods: {
        [gradingPeriod.id]: {
          gradingPeriod,
          assignmentRefs: [assignment.id],
        },
        [gradingPeriodTwo.id]: {
          gradingPeriod: gradingPeriodTwo,
          assignmentRefs: [],
        },
      },
    },
    favoriteCourses: [],
  })

  let props: AssignmentListProps = {
    courseID: course.id,
    course: {
      course,
      color: '#fff',
    },
    assignmentGroups: [],
    updateAssignment: jest.fn(),
    refreshAssignmentList: jest.fn(),
    refreshGradingPeriods: jest.fn(),
    refreshAssignment: jest.fn(),
    refresh: jest.fn(),
    cancelAssignmentUpdate: jest.fn(),
    refreshing: false,
    pending: 0,
    navigator: template.navigator(),
    gradingPeriods: [],
    courseColor: 'greenish',
  }

  const result = mapStateToProps(state, props)
  expect(result).toMatchObject({
    assignmentGroups: [assignmentGroup],
    gradingPeriods: [{
      ...gradingPeriod,
      assignmentRefs: [assignment.id],
    }, {
      ...gradingPeriodTwo,
      assignmentRefs: [],
    }],
    courseColor: 'blueish',
  })
})

test('returns default props when the course is not there', () => {
  let state = template.appState()

  let props = {
    courseID: '1',
    refreshAssignmentList: jest.fn(),
    refreshGradingPeriods: jest.fn(),
    refresh: jest.fn(),
    refreshing: false,
    navigator: template.navigator(),
    assignmentGroups: [],
    course: {
      course: template.course(),
      color: '#fff',
    },
    gradingPeriods: [],
    pending: 0,
  }

  let result = mapStateToProps(state, props)
  expect(result).toMatchObject({
    course: null,
    assignmentGroups: [],
    pending: 0,
  })
})
