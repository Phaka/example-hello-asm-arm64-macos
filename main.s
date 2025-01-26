// ARM64 assembly for macOS
// System call numbers for ARM64 macOS:
// 0x2000004 for write
// 0x2000001 for exit
.global _main
.align 2

.data
    message: .ascii "Hello, World!\n"
    message_len = . - message

.text
_main:
    // Save frame pointer
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // Write system call
    mov x0, #1              // File descriptor 1 is stdout
    adrp x1, message@PAGE   // Get page address of message
    add x1, x1, message@PAGEOFF // Add offset within page
    mov x2, #14             // Message length (including newline)
    mov x16, #0x2000004     // macOS write system call number
    svc #0x80              // Make system call

    // Exit system call
    mov x0, #0              // Return code 0
    mov x16, #0x2000001     // macOS exit system call number
    svc #0x80              // Make system call

    // Restore frame pointer
    ldp x29, x30, [sp], #16
    ret
