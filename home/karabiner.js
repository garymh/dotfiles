// Karabiner-Elements complex modifications
// Converted from Goku EDN configuration
// JavaScript must be written in ECMAScript 5.1.
//
// Global parameters (set these in Karabiner-Elements profile settings):
//   basic.simultaneous_threshold_milliseconds: 500
//   basic.to_delayed_action_delay_milliseconds: 500
//   basic.to_if_alone_timeout_milliseconds: 500
//   basic.to_if_held_down_threshold_milliseconds: 100

function main() {
  var manipulators = [];

  // --- Device identifiers (from :devices) ---
  var devices = {
    topre:        [{ vendor_id: 2131, product_id: 308 }],
    pikatea:      [{ vendor_id: 9025, product_id: 32822 }],
    macbook:      [{ is_built_in_keyboard: true }],
    nuphy:        [{ vendor_id: 6645, product_id: 12869 }],
    ergo:         [{ vendor_id: 12951, product_id: 8208 }],
    nuphy_dongle: [{ vendor_id: 6645, product_id: 12871 }],
    mouse:        [{ vendor_id: 5426, product_id: 123 }],
    qmkbundle:    [{ vendor_id: 6645 }, { is_built_in_keyboard: true }, { vendor_id: 1452, product_id: 834 }],
    lemokey:      [{ vendor_id: 13869 }]
  };

  // --- Application bundle identifiers (from :applications) ---
  var apps = {
    firefox:      ['^org\\.mozilla\\.firefox'],
    firefoxdev:   ['^org\\.mozilla\\.firefoxdeveloperedition$'],
    firefoxnight: ['^org\\.mozilla\\.nightly$'],
    finder:       ['^com\\.apple\\.finder'],
    mail:         ['^com\\.apple\\.mail'],
    onep:         ['^com\\.1password\\.1password'],
    kitty:        ['^net\\.kovidgoyal\\.kitty'],
    reeder:       ['^com\\.reederapp\\.5\\.macOS'],
    safari:       ['^com\\.apple\\.Safari'],
    helium:       ['^net\\.imput\\.helium'],
    brave:        ['^com\\.brave\\.Browser\\.beta$'],
    neovide:      ['^com\\.neovide\\.neovide'],
    omnifocus:    ['^com\\.omnigroup\\.OmniFocus3$'],
    firefoxes:    ['^org\\.mozilla\\.firefox', '^org\\.mozilla\\.firefoxdeveloperedition$', '^org\\.mozilla\\.nightly$'],
    terminal:     ['^com\\.apple\\.Terminal'],
    ghostty:      ['^com\\.mitchellh\\.ghostty'],
    terminals:    ['^io\\.alacritty', '^net\\.kovidgoyal\\.kitty', '^com\\.apple\\.Terminal', '^com\\.github\\.wez\\.wezterm', '^com\\.mitchellh\\.ghostty']
  };

  // --- Helpers ---
  function devCond(name) {
    return { type: 'device_if', identifiers: devices[name] };
  }

  function appCond(name) {
    return { type: 'frontmost_application_if', bundle_identifiers: apps[name] };
  }

  function varCond(name, value) {
    return { type: 'variable_if', name: name, value: value };
  }

  function setVar(name, value) {
    return { set_variable: { name: name, value: value } };
  }

  // ============================================================
  // Double-tap option -> omnifocus
  // ============================================================

  // When variable is set: tap sends hyper+x and resets variable
  manipulators.push({
    type: 'basic',
    from: { key_code: 'left_option', modifiers: { optional: ['any'] } },
    to: [{ key_code: 'left_option' }],
    to_if_alone: [
      { key_code: 'x', modifiers: ['left_command', 'left_control', 'left_option', 'left_shift'] },
      setVar('tunadt_left_opt_pressed', 0)
    ],
    conditions: [varCond('tunadt_left_opt_pressed', 1)]
  });

  // First tap: set variable, delayed reset
  manipulators.push({
    type: 'basic',
    from: { key_code: 'left_option', modifiers: { optional: ['any'] } },
    to: [{ key_code: 'left_option' }],
    to_if_alone: [setVar('tunadt_left_opt_pressed', 1)],
    to_delayed_action: {
      to_if_invoked: [setVar('tunadt_left_opt_pressed', 0)],
      to_if_canceled: [setVar('tunadt_left_opt_pressed', 0)]
    },
    parameters: {
      'basic.to_if_alone_timeout_milliseconds': 300,
      'basic.to_delayed_action_delay_milliseconds': 300
    }
  });

  // ============================================================
  // right option to globe/fn
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'right_option', modifiers: { optional: ['any'] } },
    to: [{ key_code: 'fn' }]
  });

  // ============================================================
  // fn key -> hyper key or f16 if alone (qmkbundle only)
  // ============================================================

  // fn -> nothing; alone: f16; held: hyper
  manipulators.push({
    type: 'basic',
    from: { key_code: 'fn', modifiers: { optional: ['any'] } },
    to: [],
    to_if_alone: [{ key_code: 'f16' }],
    to_if_held_down: [{ key_code: 'left_shift', modifiers: ['left_command', 'left_control', 'left_option', 'left_shift'] }],
    conditions: [devCond('qmkbundle')],
    parameters: {
      'basic.to_if_alone_timeout_milliseconds': 500,
      'basic.to_if_held_down_threshold_milliseconds': 100
    }
  });

  // left_control -> hyper; alone: f16 (qmkbundle only)
  manipulators.push({
    type: 'basic',
    from: { key_code: 'left_control', modifiers: { optional: ['any'] } },
    to: [{ key_code: 'left_shift', modifiers: ['left_command', 'left_control', 'left_option', 'left_shift'] }],
    to_if_alone: [{ key_code: 'f16' }],
    conditions: [devCond('qmkbundle')],
    parameters: {
      'basic.to_if_alone_timeout_milliseconds': 500,
      'basic.to_if_held_down_threshold_milliseconds': 100
    }
  });

  // caps_lock -> right_control; alone: f15 (qmkbundle only)
  manipulators.push({
    type: 'basic',
    from: { key_code: 'caps_lock', modifiers: { optional: ['any'] } },
    to: [{ key_code: 'right_control' }],
    to_if_alone: [{ key_code: 'f15' }],
    conditions: [devCond('qmkbundle')],
    parameters: {
      'basic.to_if_alone_timeout_milliseconds': 500,
      'basic.to_if_held_down_threshold_milliseconds': 100
    }
  });

  // f15 -> right_control; alone: f15 (qmkbundle only)
  manipulators.push({
    type: 'basic',
    from: { key_code: 'f15', modifiers: { optional: ['any'] } },
    to: [{ key_code: 'right_control' }],
    to_if_alone: [{ key_code: 'f15' }],
    conditions: [devCond('qmkbundle')],
    parameters: {
      'basic.to_if_alone_timeout_milliseconds': 500,
      'basic.to_if_held_down_threshold_milliseconds': 100
    }
  });

  // ============================================================
  // shift + delete -> forward delete
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'delete_or_backspace', modifiers: { mandatory: ['left_shift'] } },
    to: [{ key_code: 'delete_forward' }]
  });

  // ============================================================
  // cmd space -> Alfred
  // ============================================================

  // cmd+space -> f18 + set in-alfred variable
  manipulators.push({
    type: 'basic',
    from: { key_code: 'spacebar', modifiers: { mandatory: ['left_command'] } },
    to: [
      { key_code: 'f18' },
      setVar('in-alfred', 1)
    ]
  });

  // When in-alfred: enter -> enter + reset variable
  manipulators.push({
    type: 'basic',
    from: { key_code: 'return_or_enter', modifiers: { optional: ['any'] } },
    to: [
      { key_code: 'return_or_enter' },
      setVar('in-alfred', 0)
    ],
    conditions: [varCond('in-alfred', 1)]
  });

  // When in-alfred: escape -> escape + reset variable
  manipulators.push({
    type: 'basic',
    from: { key_code: 'escape', modifiers: { optional: ['any'] } },
    to: [
      { key_code: 'escape' },
      setVar('in-alfred', 0)
    ],
    conditions: [varCond('in-alfred', 1)]
  });

  // When in-alfred: ctrl+l -> enter + reset variable
  manipulators.push({
    type: 'basic',
    from: { key_code: 'l', modifiers: { mandatory: ['left_control'] } },
    to: [
      { key_code: 'return_or_enter' },
      setVar('in-alfred', 0)
    ],
    conditions: [varCond('in-alfred', 1)]
  });

  // ============================================================
  // |mail| ctrl+c -> cmd+shift+c (conversations)
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'c', modifiers: { mandatory: ['left_control'] } },
    to: [{ key_code: 'c', modifiers: ['left_command', 'left_shift'] }],
    conditions: [appCond('mail')]
  });

  // ============================================================
  // |mail| ctrl+/ -> cmd+opt+f
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'slash', modifiers: { mandatory: ['right_control'] } },
    to: [{ key_code: 'f', modifiers: ['left_command', 'left_option'] }],
    conditions: [appCond('mail')]
  });

  // ============================================================
  // |mail| cmd+opt+return -> shift+cmd+d
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'return_or_enter', modifiers: { mandatory: ['left_command', 'left_option'] } },
    to: [{ key_code: 'd', modifiers: ['left_shift', 'left_command'] }],
    conditions: [appCond('mail')]
  });

  // ============================================================
  // |reeder| cmd+shift+r -> r
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'r', modifiers: { mandatory: ['left_command', 'left_shift'] } },
    to: [{ key_code: 'r' }],
    conditions: [appCond('reeder')]
  });

  // ============================================================
  // |safari| undo close window/tab
  // ============================================================

  // cmd+shift+n -> cmd+shift+t (reopen tab)
  manipulators.push({
    type: 'basic',
    from: { key_code: 'n', modifiers: { mandatory: ['left_command', 'left_shift'] } },
    to: [{ key_code: 't', modifiers: ['left_command', 'left_shift'] }],
    conditions: [appCond('safari')]
  });

  // cmd+shift+z -> cmd+shift+t (undo close tab)
  manipulators.push({
    type: 'basic',
    from: { key_code: 'z', modifiers: { mandatory: ['left_command', 'left_shift'] } },
    to: [{ key_code: 't', modifiers: ['left_command', 'left_shift'] }],
    conditions: [appCond('safari')]
  });

  // cmd+shift+p -> cmd+shift+n (private window)
  manipulators.push({
    type: 'basic',
    from: { key_code: 'p', modifiers: { mandatory: ['left_command', 'left_shift'] } },
    to: [{ key_code: 'n', modifiers: ['left_command', 'left_shift'] }],
    conditions: [appCond('safari')]
  });

  // ============================================================
  // |helium| private window
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'p', modifiers: { mandatory: ['left_command', 'left_shift'] } },
    to: [{ key_code: 'n', modifiers: ['left_command', 'left_shift'] }],
    conditions: [appCond('helium')]
  });

  // ============================================================
  // |brave| private window
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'p', modifiers: { mandatory: ['left_command', 'left_shift'] } },
    to: [{ key_code: 'n', modifiers: ['left_command', 'left_shift'] }],
    conditions: [appCond('brave')]
  });

  // ============================================================
  // |ghostty| shortcuts
  // ============================================================

  // cmd+shift+f -> opt+f
  manipulators.push({
    type: 'basic',
    from: { key_code: 'f', modifiers: { mandatory: ['left_command', 'left_shift'] } },
    to: [{ key_code: 'f', modifiers: ['left_option'] }],
    conditions: [appCond('ghostty')]
  });

  // cmd+shift+g -> opt+g
  manipulators.push({
    type: 'basic',
    from: { key_code: 'g', modifiers: { mandatory: ['left_command', 'left_shift'] } },
    to: [{ key_code: 'g', modifiers: ['left_option'] }],
    conditions: [appCond('ghostty')]
  });

  // cmd+k -> opt+k
  manipulators.push({
    type: 'basic',
    from: { key_code: 'k', modifiers: { mandatory: ['left_command'] } },
    to: [{ key_code: 'k', modifiers: ['left_option'] }],
    conditions: [appCond('ghostty')]
  });

  // cmd+p -> opt+p
  manipulators.push({
    type: 'basic',
    from: { key_code: 'p', modifiers: { mandatory: ['left_command'] } },
    to: [{ key_code: 'p', modifiers: ['left_option'] }],
    conditions: [appCond('ghostty')]
  });

  // ============================================================
  // |1password| easier shortcut
  // ============================================================

  // cmd+l -> cmd+f
  manipulators.push({
    type: 'basic',
    from: { key_code: 'l', modifiers: { mandatory: ['left_command'] } },
    to: [{ key_code: 'f', modifiers: ['left_command'] }],
    conditions: [appCond('onep')]
  });

  // ============================================================
  // |terminals| vim history fix
  // ============================================================

  // ctrl+i -> f6
  manipulators.push({
    type: 'basic',
    from: { key_code: 'i', modifiers: { mandatory: ['left_control'] } },
    to: [{ key_code: 'f6' }],
    conditions: [appCond('terminals')]
  });

  // ============================================================
  // |terminal| opt+delete -> ctrl+w
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'delete_or_backspace', modifiers: { mandatory: ['left_option'] } },
    to: [{ key_code: 'w', modifiers: ['left_control'] }],
    conditions: [appCond('terminal')]
  });

  // ============================================================
  // |terminals| cmd+delete -> ctrl+u
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'delete_or_backspace', modifiers: { mandatory: ['left_command'] } },
    to: [{ key_code: 'u', modifiers: ['left_control'] }],
    conditions: [appCond('terminals')]
  });

  // ============================================================
  // |terminals| cmd+return -> opt+return
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'return_or_enter', modifiers: { mandatory: ['left_command'] } },
    to: [{ key_code: 'return_or_enter', modifiers: ['left_option'] }],
    conditions: [appCond('terminals')]
  });

  // ============================================================
  // |terminal| cmd+left -> ctrl+a
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'left_arrow', modifiers: { mandatory: ['left_command'] } },
    to: [{ key_code: 'a', modifiers: ['left_control'] }],
    conditions: [appCond('terminal')]
  });

  // ============================================================
  // |terminal| cmd+right -> ctrl+e
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'right_arrow', modifiers: { mandatory: ['left_command'] } },
    to: [{ key_code: 'e', modifiers: ['left_control'] }],
    conditions: [appCond('terminal')]
  });

  // ============================================================
  // |terminal| ctrl+cmd+h -> ctrl+a
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'h', modifiers: { mandatory: ['left_command', 'left_control'] } },
    to: [{ key_code: 'a', modifiers: ['left_control'] }],
    conditions: [appCond('terminal')]
  });

  // ============================================================
  // |terminal| ctrl+cmd+l -> ctrl+e
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'l', modifiers: { mandatory: ['left_command', 'left_control'] } },
    to: [{ key_code: 'e', modifiers: ['left_control'] }],
    conditions: [appCond('terminal')]
  });

  // ============================================================
  // |omnifocus| defer to tomorrow
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'right_arrow', modifiers: { mandatory: ['left_command'] } },
    to: [{ shell_command: 'osascript "$HOME/iCloud/Internal/custom/applescripts/defer-to-tomorrow.scpt"' }],
    conditions: [appCond('omnifocus')]
  });

  // ============================================================
  // vim arrow keys (right_control + h/j/k/l)
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'h', modifiers: { mandatory: ['right_control'], optional: ['any'] } },
    to: [{ key_code: 'left_arrow' }]
  });

  manipulators.push({
    type: 'basic',
    from: { key_code: 'l', modifiers: { mandatory: ['right_control'], optional: ['any'] } },
    to: [{ key_code: 'right_arrow' }]
  });

  manipulators.push({
    type: 'basic',
    from: { key_code: 'k', modifiers: { mandatory: ['right_control'], optional: ['any'] } },
    to: [{ key_code: 'up_arrow' }]
  });

  manipulators.push({
    type: 'basic',
    from: { key_code: 'j', modifiers: { mandatory: ['right_control'], optional: ['any'] } },
    to: [{ key_code: 'down_arrow' }]
  });

  // ============================================================
  // vim arrow keys (left_control + h/j/k/l)
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'h', modifiers: { mandatory: ['left_control'], optional: ['any'] } },
    to: [{ key_code: 'left_arrow' }]
  });

  manipulators.push({
    type: 'basic',
    from: { key_code: 'l', modifiers: { mandatory: ['left_control'], optional: ['any'] } },
    to: [{ key_code: 'right_arrow' }]
  });

  manipulators.push({
    type: 'basic',
    from: { key_code: 'k', modifiers: { mandatory: ['left_control'], optional: ['any'] } },
    to: [{ key_code: 'up_arrow' }]
  });

  manipulators.push({
    type: 'basic',
    from: { key_code: 'j', modifiers: { mandatory: ['left_control'], optional: ['any'] } },
    to: [{ key_code: 'down_arrow' }]
  });

  // ============================================================
  // clear notifications (hyper+delete -> Alfred workflow)
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'delete_or_backspace', modifiers: { mandatory: ['left_command', 'left_control', 'left_option', 'left_shift'] } },
    to: [{ shell_command: 'osascript -e \'tell application id "com.runningwithcrayons.Alfred" to run trigger "clearnots" in workflow "com.garys.stuff"\'' }]
  });

  // ============================================================
  // mousetest (mouse only)
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'keypad_1' },
    to: [{ key_code: 'f15' }],
    conditions: [devCond('mouse')]
  });

  manipulators.push({
    type: 'basic',
    from: { key_code: 'keypad_2' },
    to: [{ key_code: 'f15', modifiers: ['left_shift'] }],
    conditions: [devCond('mouse')]
  });

  // ============================================================
  // double shift -> f19
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: {
      simultaneous: [{ key_code: 'left_shift' }, { key_code: 'right_shift' }],
      simultaneous_options: {
        key_down_order: 'insensitive',
        key_up_order: 'insensitive'
      }
    },
    to: [{ key_code: 'f19' }],
    parameters: {
      'basic.simultaneous_threshold_milliseconds': 500
    }
  });

  // ============================================================
  // KVM switch (shift+f24)
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'f24', modifiers: { mandatory: ['left_shift'] } },
    to: [{ shell_command: '/opt/homebrew/bin/m1ddc display 1 set input 15' }]
  });

  // ============================================================
  // F13/F14/F17 -> open Discord
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'f13' },
    to: [{ shell_command: 'open -a "/Applications/Discord.app"' }]
  });

  manipulators.push({
    type: 'basic',
    from: { key_code: 'f14' },
    to: [{ shell_command: 'open -a "/Applications/Discord.app"' }]
  });

  manipulators.push({
    type: 'basic',
    from: { key_code: 'f17' },
    to: [{ shell_command: 'open -a "/Applications/Discord.app"' }]
  });

  // ============================================================
  // F16 -> hyper+f
  // ============================================================

  manipulators.push({
    type: 'basic',
    from: { key_code: 'f16' },
    to: [{ key_code: 'f', modifiers: ['left_command', 'left_control', 'left_option', 'left_shift'] }]
  });

  // ============================================================
  // Pikatea layout keys
  // ============================================================

  // f1 -> Hammerspoon meeting layout (pikatea only)
  manipulators.push({
    type: 'basic',
    from: { key_code: 'f1' },
    to: [{ shell_command: 'osascript -e \'tell application "Hammerspoon" to execute lua code "useLayout([[meeting]])"\'' }],
    conditions: [devCond('pikatea')]
  });

  // f3 -> Hammerspoon work layout (pikatea only)
  manipulators.push({
    type: 'basic',
    from: { key_code: 'f3' },
    to: [{ shell_command: 'osascript -e \'tell application "Hammerspoon" to execute lua code "useLayout([[work]])"\'' }],
    conditions: [devCond('pikatea')]
  });

  // f4 -> Hammerspoon game layout (pikatea only)
  manipulators.push({
    type: 'basic',
    from: { key_code: 'f4' },
    to: [{ shell_command: 'osascript -e \'tell application "Hammerspoon" to execute lua code "useLayout([[game]])"\'' }],
    conditions: [devCond('pikatea')]
  });

  // f5 -> Hammerspoon chill layout (pikatea only)
  manipulators.push({
    type: 'basic',
    from: { key_code: 'f5' },
    to: [{ shell_command: 'osascript -e \'tell application "Hammerspoon" to execute lua code "useLayout([[chill]])"\'' }],
    conditions: [devCond('pikatea')]
  });

  // f2 -> Shortcuts: Pacman Ghost (pikatea only)
  manipulators.push({
    type: 'basic',
    from: { key_code: 'f2' },
    to: [{ shell_command: 'shortcuts run "AUTO: Pacman Ghost"' }],
    conditions: [devCond('pikatea')]
  });

  return {
    description: 'Gary keyboard customizations (from Goku EDN)',
    manipulators: manipulators
  };
}

main()