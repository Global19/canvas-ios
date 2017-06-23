/**
 * @flow
 */

import 'react-native'
import { SUBMISSION_TYPES } from '../submissionTypes'

test('test submission types', () => {
  expect(SUBMISSION_TYPES).toEqual(
    {
      'discussion_topic': 'Discussion Topic',
      'external_tool': 'External Tool',
      'media_recording': 'Media Recording',
      'none': 'None',
      'on_paper': 'On Paper',
      'online_quiz': 'Online Quiz',
      'online_text_entry': 'Online Text Entry',
      'online_upload': 'Online Upload',
      'online_url': 'Online URL',
    }
  )
})
