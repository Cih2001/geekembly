---
title: String obfuscation using C++ constexpr
date: 2024-06-15
description: How to do constexpr obfuscation
---

## Obfuscation

### Intro

Ever wondered how to obfuscating strings using C++ constexpr? That's the topic of this post!

Typically, when compiling a program, strings are directly embedded into the binary in their raw form.
Opening the final binary executable a hex editor, or even notepad, these strings are readily visible.
Various tools, such as "strings" in Linux, can also be used to extract these strings.

String Obfuscation is a basic method to increase software resiliency against reverse engineers.
While it does not guarantee absolute invulnerability for your software,
it serves as a fundamental measure towards bolstering binary security.

To have obfuscated strings in the final binary, we need to encrypt strings at compile time.
Unfortunately, most of the programming languages are not feature rich when it comes to compile-time function execution.
Usually, all you have is just a simple engine that enables you to write Macros.
Therefore, string obfuscation needs to be done manually with a pre-compilation script.
That will be an ugly solution, that imposes an additional step in your build process.

Here, we are going to explore an alternative using C++ `constexpr`.
The source codes for this technique is available at [GitHub](https://github.com/Cih2001/String-Obfuscator).

### C++ constexpr

The C++ `constexpr` feature enables us to specify a function or expression to the compiler,
indicating that the computation result can be evaluated at compile time if given constant parameter values.
Here is an example showcasing the calculation of the factorial of 4 during compile time using C++ `constexpr`:

```c++
#include <iostream>

constexpr int factorial(int n) {
    return n <= 1 ? 1 : n * factorial(n - 1);
}

int main() {
    constexpr int result = factorial(4);
    std::cout << "Factorial of 4 is: " << result << std::endl;

    return 0;
}
```

### Designing an string obfuscater

The code below shows how to encrypt strings with simple xor encryption method using `constexpr`.

```c++
#define KEY 0x55

template <unsigned int N>
struct obfuscator {
    // m_data stores the obfuscated string.
    char m_data[N] = {0};

    // Using constexpr ensures that the strings
    // will be obfuscated in this
    // constructor function at compile time.
    constexpr obfuscator(const char* data) {
         //Implement encryption algorithm here.
        for (unsigned int i = 0; i < N; i++) {
            m_data[i] = data[i] ^ KEY;
        }
    }
};

int main() {
    // Store "Hello" in obfuscated form using simple
    // xor encryption.
    constexpr auto obfuscated_str = obfuscator<6>("Hello");
    return 0;
}
```

In the above code, _obfuscator_ is a class with a member array that stores data encrypted.
Defining obfuscator’s constructor as constexpr ensures that this member array is encrypted at compile time.
Although any symmetric encryption algorithm can be used, we employ the simplest one here, XOR encryption.
Compiling the above code:

```sh
gcc --std=c++14 -O0 -S -masm=intel constexpr2.cc
```

And examining the generated assembly, indeed we see that the string “Hello” is stored in the encrypted form:

```asm
obfuscated_str.2087:
        .byte   29
        .byte   48
        .byte   57
        .byte   57
        .byte   58
        .byte   85
        .ident  "GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
        .section        .note.GNU-stack,"",@progbits
        .section        .note.gnu.property,"a"
```

Note that the Ascii code for ‘H’ is 72, and when _xored_ with 85 (0x55),
the result will be 29, which shows that “Hello” is stored encrypted.

To use the encrypted strings, we need to have them decrypted first.
Therefore, we create a decryption method for the “obfuscator” class:

```c++
#include "stdio.h"

#define KEY 0x55

template <unsigned int N>
struct obfuscator {
    char m_data[N] = {0};
    constexpr obfuscator(const char* data) {/*…*/};

    // deobfoscate decrypts the strings. Implement decryption
    // algorithm here.
    void deobfoscate(unsigned char * des) const{
        int i = 0;
        do {
            des[i] = m_data[i] ^ KEY;
            i++;
        } while (des[i-1]);
    }
};

int main() {
    // Store "Hello" in obfuscated form using simple xor encryption.
    constexpr auto obfuscated_str = obfuscator<6>("Hello");
    // Create a buffed to store decrypted string.
    unsigned char buff[0x10] = {0};
    // Decrypt the string
    obfuscated_str.deobfoscate(buff);
    printf("%s", buff); // output: Hello
    return 0;
}
```

Compiling above code

```sh
gcc --std=c++14 -fno-stack-protector -O0 -S -masm=intel constexpr3.cc
```

And looking at the generated assembly code again, we see that this time,
“Hello” is stored as a stack string which indeed is even better for binary protection.
Not only “Hello” is stored in an encrypted format, but also there are bytecodes in between
each character, which confuses auto analysis tools even more.

```asm
main:
.LFB2:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	BYTE PTR -6[rbp], 29
	mov	BYTE PTR -5[rbp], 48
	mov	BYTE PTR -4[rbp], 57
	mov	BYTE PTR -3[rbp], 57
	mov	BYTE PTR -2[rbp], 58
	mov	BYTE PTR -1[rbp], 85
	mov	QWORD PTR -32[rbp], 0
	mov	QWORD PTR -24[rbp], 0
	lea	rdx, -32[rbp]
	lea	rax, -6[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	_ZNK10obfuscatorILj6EE11deobfoscateEPh
	lea	rax, -32[rbp]
	mov	rsi, rax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
```

### Packing everything together

A simple macro can be used to pack everything into a single line with the employment of a lambda function:

```c++
// This macro is a lambda function to pack all required steps
// into one single command when defining strings.
#define STR(str) \
    []() -> char* { \
        constexpr auto size = sizeof(str)/sizeof(str[0]); \
        constexpr auto obfuscated_str = obfuscator<size>(str); \
        static char original_string[size]; \
        obfuscated_str.deobfoscate((unsigned char *)original_string); \
        return original_string; \
    }()
```

Using above macro and packing everything in a header file, we can simply encrypt our strings in a C++ application.

```c++
#include "obfuscator.hh"
#include "stdio.h"

auto gstr = STR("Global HELLO\n");
int main() {
    printf("%s", gstr);
    printf("%s", STR("Stack HELLO\n"));
    return 0;
}
```

### Conclusion

C++ `constexpr` makes it much more convenient to obfuscate strings at compile time.
Using this feature, we won't need any additional step in your build process.
Everything is wrapped up in our source code which also makes it cleaner.

On the flip side, note that `constexpr` is only supported on C++14 or above.
Unfortunately, C does not support `constexprs` either.
