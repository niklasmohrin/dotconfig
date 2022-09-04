#!/usr/bin/env python3

import argparse
import subprocess

INTERNAL_DISPLAY = "eDP-1"
EXTERNAL_DISPLAY = "DP-3"
INTERNAL_RESOLUTION = "1920x1080"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-m",
        "--mode",
        choices=["primary", "secondary", "mirror", "single"],
        required=True,
    )
    parser.add_argument(
        "-d", "--direction", choices=["left", "right", "above", "below"]
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
    )
    args = parser.parse_args()

    if args.mode == "single":
        subprocess.run(["xrandr", "--output", EXTERNAL_DISPLAY, "--off"])
        return

    internal_args = []
    external_args = []
    if args.mode == "mirror":
        assert args.direction is None
        external_args += [
            "--scale-from",
            INTERNAL_RESOLUTION,
            "--same-as",
            INTERNAL_DISPLAY,
        ]
    else:
        if args.mode == "secondary":
            internal_args.append("--primary")
        else:
            external_args.append("--primary")
        external_args += [
            f'--{args.direction}{"-of" if args.direction in ["left", "right"] else ""}',
            INTERNAL_DISPLAY,
        ]

    print(f"{internal_args=}\n{external_args=}")

    full_command = [
        "xrandr",
        "--output",
        INTERNAL_DISPLAY,
        *internal_args,
        "--auto",
        "--output",
        EXTERNAL_DISPLAY,
        "--auto",
        *external_args,
    ]
    print(f"{full_command=}")
    print(" ".join(full_command))
    if not args.dry_run:
        subprocess.run(full_command)


if __name__ == "__main__":
    main()
