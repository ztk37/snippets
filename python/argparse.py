#! /usr/bin/env python

import argparse

def run(args):
    print(args.foo)

def main():
    parser = argparse.ArgumentParser(description="")
    parser.add_argument('--foo', help='foo help')
    parser.set_defaults(func=run)
    args = parser.parse_args()
    args.func(args)

if __name__ == "__main__":
    main()
