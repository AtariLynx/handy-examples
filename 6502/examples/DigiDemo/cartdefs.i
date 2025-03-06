
*****************************************
*                                       *
* CARTDEFS.I                            *
*                                       *
* ROM cart layout description			*
*                                       *
*****************************************


ROM_HEADER_SIZE     .EQ 410


* file number definitions

FIRST_FONT_FILE	.eq 2
LILFONT			.eq 0
PLAINFONT		.eq 1

FIRST_SOUND_FILE	.eq 4
NUMSOUNDS			.eq 5

* standard rj cart definitions

ROMDIR_PAGE         .EQU    0   ; This field is required
ROMDIR_OFFSET       .EQU    1   ; This field is required
ROMDIR_FLAG         .EQU    3
ROMDIR_DEST         .EQU    4
ROMDIR_SIZE         .EQU    6   ; This field is required
ROMDIR_ENTRY_SIZE   .EQU    8   ; This field is required


* The ROMFILE_ALIGN value is used to define the byte boundary to which the 
* file's first byte will be aligned.   This constant must be defined, and it 
* must have a reasonable power-of-2 value (such as 1, 2, 4, 8, etc).  
ROMFILE_ALIGN       .EQU    1


* Edit this value as needed to declare the size of your ROM.  
ROMSIZE         .EQU    $100*512


* If you don't want a file directory in your ROM and you aren't going to be 
* using the CART file system, you should define the ROM_NODIR constant.  If 
* ROM_NODIR is defined, the file system support code will be omitted when the 
* CART system is assembled and HandyROM will not add a directory to your ROM.
; ROM_NODIR


* This value is used by the ROM loader when blanking the display to a solid 
* color.  This value is written to all of the GREEN and BLUERED registers.
;ROM_SCREENBLANK_VALUE  .EQU    $F3 ; Clear to blue-grey
ROM_SCREENBLANK_VALUE   .EQU    $00 ; Clear to black


* Edit this value as needed to declare the number of pages in your ROM.  
* You should never need to change this value!
ROMPAGECOUNT        .EQU    256



* --------------------------------------------------------------------------
* These constants should not be edited.  You should allow their values to 
* be computed based on the values that you've entered above.  
ROMPAGESIZE     .EQU    ROMSIZE/ROMPAGECOUNT
ROMDIR_FILE0_PAGE   .EQU    ROM_HEADER_SIZE/ROMPAGESIZE
ROMDIR_FILE0_OFFSET .EQU    ROM_HEADER_SIZE-{ROMDIR_FILE0_PAGE*ROMPAGESIZE}
ROMDIR_FILE1_LOC    .EQU    ROM_HEADER_SIZE+ROMDIR_ENTRY_SIZE
ROMDIR_FILE1_PAGE   .EQU    ROMDIR_FILE1_LOC/ROMPAGESIZE
ROMDIR_FILE1_OFFSET .EQU    ROMDIR_FILE1_LOC-{ROMDIR_FILE0_PAGE*ROMPAGESIZE}
* --------------------------------------------------------------------------
