import { map, rule } from 'karabiner.ts'

import { inApp } from '../apps.ts'
import { toScript } from '../applescripts.ts'

const omnifocusDeferRule = rule('|omnifocus| defer to tomorrow', inApp('omnifocus')).manipulators(
  [map('right_arrow', 'left_command').to(toScript('defer-to-tomorrow.scpt'))],
)

export default [omnifocusDeferRule]
