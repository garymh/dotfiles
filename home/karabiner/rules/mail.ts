import { map, rule } from 'karabiner.ts'

import { inApp } from '../apps.ts'

const mailConversationsRule = rule(
  '|mail| <c-c> to ⌘⇧c (conversations)',
  inApp('mail'),
).manipulators([map('c', 'left_control').to('c', ['left_command', 'left_shift'])])

const mailSearchRule = rule('|mail| <c-/> to ⌘⌥f', inApp('mail')).manipulators([
  map('slash', 'left_control').to('f', ['left_command', 'left_option']),
])

const mailSendRule = rule('|mail| ⌘return sends', inApp('mail')).manipulators([
  map('return_or_enter', 'left_command').to('d', ['left_command', 'left_shift']),
])

const reederRefreshRule = rule('|reeder| ⌘⇧r -> R', inApp('reeder')).manipulators([
  map('r', ['left_command', 'left_shift']).to('r'),
])

export default [mailConversationsRule, mailSearchRule, mailSendRule, reederRefreshRule]
