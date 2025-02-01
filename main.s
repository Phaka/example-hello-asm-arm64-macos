// ARM64 assembly for macOS
.global _main
.align 2

.data
.align 4
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
    mov x2, message_len     // Message length
    movz x16, #0x4         // Load lower 16 bits of write syscall
    movk x16, #0x2000, lsl #16  // Load upper 16 bits of write syscall
    svc #0x80              // Make system call

    // Exit system call
    mov x0, #0              // Return code 0
    movz x16, #0x1         // Load lower 16 bits of exit syscall
    movk x16, #0x2000, lsl #16  // Load upper 16 bits of exit syscall
    svc #0x80              // Make system call

    // Restore frame pointer
    ldp x29, x30, [sp], #16
    ret