#!/usr/bin/env python3
import os
import json
import time
import subprocess

PIPE_PATH = "/tmp/swayidle-timer"
PAUSE_ICON = ""
SWAYIDLE_PROC_NAME = "swayidle"

def make_fifo(path):
    if not os.path.exists(path):
        os.mkfifo(path)

def print_json(text, clss):
    print(json.dumps({"text": text, "class": clss}), flush=True)

def send_signal(sig):
    subprocess.run(["pkill", f"-{sig}", "-f", SWAYIDLE_PROC_NAME])

def pause_swayidle():
    send_signal("STOP")

def resume_swayidle():
    send_signal("CONT")

def read_line(fd):
    try:
        return os.read(fd, 1024).decode().strip()
    except BlockingIOError:
        return None
    except Exception:
        return None

def format_time(seconds):
    if seconds > 60:
        return f"{seconds // 60}:{seconds % 60:02d}"
    else:
        return f"{seconds // 60}:{seconds % 60:02d}"

def main():
    make_fifo(PIPE_PATH)
    fifo_fd = os.open(PIPE_PATH, os.O_RDWR | os.O_NONBLOCK)

    timeout_minutes = 5
    timer_seconds = 0
    state = "NT"  # NT: no timer, T: countdown, P: paused

    while True:
        line = read_line(fifo_fd)

        if line:
            if line == "click":
                if state != "P":
                    pause_swayidle()
                    state = "P"
                    print_json(PAUSE_ICON, "paused")
                else:
                    resume_swayidle()
                    state = "NT"
                    print_json(str(timeout_minutes), "notimer")
            elif line.startswith("_"):
                try:
                    timeout_seconds = int(line[1:])
                    timeout_minutes = timeout_seconds // 60
                    print_json(str(timeout_minutes), "notimer")
                    state = "NT"
                except ValueError:
                    pass
            elif line.isdigit():
                timer_seconds = int(line)
                state = "T"

        if state == "NT":
            print_json(str(timeout_minutes), "notimer")

        elif state == "T":
            print_json(format_time(timer_seconds), "timer")
            timer_seconds -= 1
            if timer_seconds <= 0:
                state = "NT"
                print_json(str(timeout_minutes), "notimer")

        elif state == "P":
            print_json(PAUSE_ICON, "paused")

        time.sleep(1)

if __name__ == "__main__":
    main()
