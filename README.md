# Hello World in ARM64 Assembly (macOS)

A simple Hello World implementation in ARM64 assembly language for macOS systems.

## Installation

### macOS
Install Xcode Command Line Tools:
```bash
xcode-select --install
```

## Running

Assemble and link:
```bash
as -o main.o main.s
ld -o hello main.o -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main -arch arm64
./hello
```

## Code Explanation

The implementation uses macOS system calls for ARM64 architecture. Several key differences from Linux include:

1. Symbol names are prefixed with underscore (_main instead of _start)
2. System call numbers are different (0x2000004 for write, 0x2000001 for exit)
3. System calls use x16 register instead of x8
4. Page-based addressing is required (using @PAGE and @PAGEOFF)
5. Frame pointer management is required for macOS ABI compliance

The program structure:

1. Data section contains our "Hello, World!\n" message
2. Text section contains the program logic using two system calls:
   - write (syscall 0x2000004) outputs our message to stdout
   - exit (syscall 0x2000001) terminates the program

The linking process is more complex on macOS, requiring:
- Linking against system libraries (-lSystem)
- Specifying the system root (-syslibroot)
- Setting the entry point (-e _main)
- Specifying the architecture (-arch arm64)
