def main(args):
    return args


def handle_result(args, result, target_window_id, boss):
    if args[1] == "next":
        boss.active_tab.next_window()
    elif args[1] == "prev":
        boss.active_tab.prev_window()
    else:
        boss.active_tab.neighboring_window(args[1])

handle_result.no_ui = False
