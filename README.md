# Examples from Handy Development System

Included are the original examples of the Handy Development System revision 1.6.

It includes the `6502:examples` folder on the branch `original`.
The `main` branch has a reworked structure and has assembled and compiled binaries, roms and emulator files.

You can attach the contents of a cloned main branch to an WinUAE or FS-UAE emulator with the Handy development kit installed. All examples are recreatable following the instructions in the other `README.md` files.

## Fixing RUN address

The sources of the examples `multiply`, `mult32`, `divide` and `spritedemo` specify a `.RUN` located after the first data. The examples were created to be tested on Pinky/Mandy or Howard/Howdy using the `Handebug` or `Mandebug`. Using either debugger it is possible to load a binary file first and then set the `RUN` address. The last bytes of the binary file actually specify this run address:

```
03 C2 44 00
```

where `03` is the command for `RUN` address and `C2 44` is the low byte/high byte value for the start address at `$44C2`.

The directory entries are not designed to have a run address that is different than the load address, so these ROMs do not start properly, as the code will start execution at the load address of `$426B`.

To fix this there are two approaches:

1. Change the source code to start with the code instead of font definitions  
   This significantly changes the code, so hasn't been done for the current examples.

2. Hand-edit the files `mult32.bin`, `multiply.bin`, `divide.bin` and `spritedemo.bin`  
   Insert a `JMP <run-address>` in front of the start of the load address. This will take three additional bytes, that need to be loaded before the current load address. The length of the section will be three bytes longer.

   For example, take `mult32.src`  
   Run: `asm mult32.src`  
   Edit the `mult32.bin` to load at `address - 3`, `length + 3` and do a `JMP <run-address>`.

   For example, take a binary that is loaded at `$426B` and has a length of `$0C07`. If the start address is located at `$YYXX` you can change the binary content of the `.bin` file:

   ```
   Load      Length     Code
   01 6B 42  12 0C 07   AD 67 42 ...
   ```

   After editing this is changed to be: 

   ```
      -3        +3     JMP $YYXX
   01 68 42  12 0F 07  4C XX YY  AD 67 42 ...
   ```
   
   Run `HandyROM` as usual to create a ROM file and any tooling such as `make_lnx` to give it an emulator header.