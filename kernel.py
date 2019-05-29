#! /usr/bin/env python3
# flake8: noqa E501
import random
import sys
import subprocess
import tempfile
import queue
import threading
from math import floor
from time import sleep

update_shell_command = "yay"

states = [
    "establishing connection...",
    "hiding ip address...",
    "looking up package repository location...",
    "resolving GPS coordinates...",
    "requesting current kernel version...",
    "politely requesting current kernel version...",
    "preparing safe download route through darknet...",
    "downloading new kernel...",
    "eliminating digital traces...",
    "compiling kernel with kyub module...",
    "deploying zen to new kernel...",
    "updating boot manager configuration...",
    "purging old kernel versions...",
    "recycling wrapping cartonage of new kernel package..."
]


def byte_to_print_char(byte, highlight):
    string = "."

    if byte >= 33 and byte <= 126:
        string = chr(byte)

    if highlight:
        string = "\033[91m" + string + "\033[0m"

    return string


def byte_to_hex_string(byte, highlight):
    string = "{:02x}".format(byte)

    if highlight:
        string = "\033[91m" + string + "\033[0m"

    return string

def handle_user_input_if_necessary(stream, stdout_buffer):
    decoded = stdout_buffer.decode()
    last_char = decoded[-1] if decoded else ""
    stripped = decoded.strip()
    last_stripped_char = stripped[-1] if stripped else ""

    if last_stripped_char in [":", ">", "?", "]"] and last_char == " ":
        sys.stdout.write(stdout_buffer.decode())
        stdout_buffer = b''
        sys.stdout.flush()

        user_input = sys.stdin.readline()

        stream.write(user_input.encode())
        stream.flush()

    return stdout_buffer

def read_to_buffer(q, buf):
    while True:
        try:
            line = q.get(True, 0.01)
            buf += line;
        except queue.Empty:
            return buf;

def enqueue_output(out, queue):
    for line in iter(lambda: out.read(1), b''):
        queue.put(line)
    out.close()


counter = 0
state = 0

update_process = subprocess.Popen(
    update_shell_command,
    shell=True,
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    stderr=subprocess.STDOUT,
    close_fds=True
)

stdout_queue = queue.Queue()
stdout_thread = threading.Thread(target=enqueue_output, args=(update_process.stdout, stdout_queue))
stdout_thread.daemon = True
stdout_thread.start()
stdout_buffer = b''

while True:
    sys.stdout.write("\r")
    sys.stdout.write("\033[K")

    stdout_buffer = read_to_buffer(stdout_queue, stdout_buffer)

    stdout_buffer = handle_user_input_if_necessary(
        update_process.stdin,
        stdout_buffer,
    )

    sys.stdout.write("{:08x}  ".format(counter))

    highlight_position = random.randint(0, 15)
    highlight_length = random.randint(1, 3)
    highlights = range(
        highlight_position,
        highlight_position + highlight_length
    )

    bytes_and_highlights = ((random.getrandbits(8), i in highlights) for i in range(8))
    sys.stdout.write(" ".join(byte_to_hex_string(byte, highlight) for (byte, highlight) in bytes_and_highlights))
    sys.stdout.write("  ")

    bytes_and_highlights = ((random.getrandbits(8), i in highlights) for i in range(8))
    sys.stdout.write(" ".join(byte_to_hex_string(byte, highlight) for (byte, highlight) in bytes_and_highlights))
    sys.stdout.write("  ")

    bytes_and_highlights = ((random.getrandbits(8), i in highlights) for i in range(16))
    sys.stdout.write("|")
    sys.stdout.write("".join(byte_to_print_char(byte, highlight) for (byte, highlight) in bytes_and_highlights))
    sys.stdout.write("|")
    sys.stdout.write("\n")

    blocks = round(state / len(states) * 80)
    spaces = 80 - blocks
    sys.stdout.write("[")
    sys.stdout.write("-" * blocks)
    sys.stdout.write(" " * spaces)
    sys.stdout.write("]  ")
    sys.stdout.write(states[floor(state)])

    sys.stdout.flush()

    state += random.randrange(20, 101) / 10000
    counter += 16 * random.randint(1, 200)

    if state >= len(states):
        break


sys.stdout.write("\r")
sys.stdout.write("\033[K")
sys.stdout.write("[")
sys.stdout.write("-" * 80)
sys.stdout.write("]")


while update_process.poll() == None:
    stdout_buffer = read_to_buffer(stdout_queue, stdout_buffer)

    stdout_buffer = handle_user_input_if_necessary(
        update_process_stdin,
        stdout_buffer
    )

sys.stdout.write(stdout_buffer.decode())

print("")
print("Done.")
