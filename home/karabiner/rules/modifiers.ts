import { ifVar, map, rule, toKey, toSetVar } from 'karabiner.ts'

import { onDevice } from '../devices.ts'
import { hyperMods } from '../hyper.ts'

// Tap left_option twice quickly -> hyper+x (bound to an OmniFocus quick-entry
// shortcut). A single tap still passes left_option through untouched.
const doubleTapOptionRule = rule('Double-tap option ⌘ → omnifocus').manipulators([
  map('left_option', 'optionalAny')
    .to('left_option')
    .toIfAlone(toKey('x', [...hyperMods]))
    .toIfAlone(toSetVar('tunadt_left_opt_pressed', 0))
    .condition(ifVar('tunadt_left_opt_pressed', 1)),

  map('left_option', 'optionalAny')
    .to('left_option')
    .toIfAlone(toSetVar('tunadt_left_opt_pressed', 1))
    .toDelayedAction(
      toSetVar('tunadt_left_opt_pressed', 0),
      toSetVar('tunadt_left_opt_pressed', 0),
    )
    .parameters({
      'basic.to_if_alone_timeout_milliseconds': 300,
      'basic.to_delayed_action_delay_milliseconds': 300,
    }),
])

// qmkless: fn → hyper+f when tapped, hyper when held; left_control → hyper, hyper+f when tapped.
const fnHyperLayerRule = rule('fn key -> hyper key or hyper+f if alone').manipulators([
  map('fn', 'optionalAny')
    .toIfAlone(toKey('f', [...hyperMods]))
    .toIfHeldDown(toKey('left_shift', [...hyperMods]))
    .condition(onDevice('qmkless')),

  map('left_control', 'optionalAny')
    .to(toKey('left_shift', [...hyperMods]))
    .toIfAlone(toKey('f', [...hyperMods]))
    .condition(onDevice('qmkless')),
])

// Unwired backup of the old caps_lock/f15 → f15 relay that action-key.ts replaced.
export const legacyCapsLockF15RelayRule = rule(
  '[unused backup] caps_lock/f15 -> left_control, alone: f15',
).manipulators([
  map('caps_lock', 'optionalAny').to('left_control').toIfAlone('f15').condition(
    onDevice('qmkless'),
  ),
  map('f15', 'optionalAny').to('left_control').toIfAlone('f15').condition(
    onDevice('qmkless'),
  ),
])

const shiftDeleteRule = rule('shift + delete -> forward delete').manipulators([
  map('delete_or_backspace', 'left_shift').to('delete_forward'),
])

// Currently inactive upstream (kept for reference, not wired into index.ts):
//   right_option -> fn/globe
//     map('right_option', 'optionalAny').to('fn')
//   cmd+space -> Alfred (f18) with enter/escape/ctrl-l "in-alfred" passthrough

export default [doubleTapOptionRule, fnHyperLayerRule, shiftDeleteRule]
