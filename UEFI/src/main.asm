%INCLUDE "util.asm"

SectionAlignment   EQU PageTableSize
FileAlignment      EQU DiskSectorSize

Subsystem          EQU 0xA
Characteristics    EQU 0x22

DefineSections     text, rdata

Section.text.char  EQU 0x60000020
Section.rdata.char EQU 0x40000040

SECTION Header START=0

Header.begin:

Header.DOS:
DB "MZ"                 ; e_magic
DB 0x3A DUP 0           ; Unused
DD Header.COFF          ; e_lfanew

Header.COFF:
DB "PE", 0, 0           ; Signature
DW Machine              ; Machine
DW NumberOfSections     ; NumberOfSections
DD 0                    ; TimeDateStamp
DD 0                    ; PointerToSymbolTable
DD 0                    ; NumberOfSymbols
DW SizeOfOptionalHeader ; SizeOfOptionalHeader
DW Characteristics      ; Characteristics

Header.Optional.begin:

Header.COFF.StandardFields:
DW Magic                ; Magic
DB 0                    ; MajorLinkerVersion
DB 0                    ; MinorLinkerVersion
DD 0                    ; SizeOfCode
DD 0                    ; SizeOfInitializedData
DD 0                    ; SizeOfUninitializedData
DD Section.text.vstart  ; AddressOfEntryPoint
DD 0                    ; BaseOfCode

Header.COFF.WindowsSpecificFields:
DQ 0                    ; ImageBase
DD SectionAlignment     ; SectionAlignment
DD FileAlignment        ; FileAlignment
DW 0                    ; MajorOperatingSystemVersion
DW 0                    ; MinorOperatingSystemVersion
DW 0                    ; MajorImageVersion
DW 0                    ; MinorImageVersion
DW 0                    ; MajorSubsystemVersion
DW 0                    ; MinorSubsystemVersion
DD 0                    ; Win32VersionValue
DD SizeOfImage          ; SizeOfImage
DD SizeOfHeaders        ; SizeOfHeaders
DD 0                    ; CheckSum
DW Subsystem            ; Subsystem
DW 0                    ; DllCharacteristics
DQ 0                    ; SizeOfStackReserve
DQ 0                    ; SizeOfStackCommit
DQ 0                    ; SizeOfHeapReserve
DQ 0                    ; SizeOfHeapCommit
DD 0                    ; LoaderFlags
DD 16                   ; NumberOfRvaAndSizes

Header.COFF.DataDirectories:
DD 0                    ;  1.1 : ExportTable
DD 0                    ;  1.2 : Size
DD 0                    ;  2.1 : ImportTable
DD 0                    ;  2.2 : Size
DD 0                    ;  3.1 : ResourceTable
DD 0                    ;  3.2 : Size
DD 0                    ;  4.1 : ExceptionTable
DD 0                    ;  4.2 : Size
DD 0                    ;  5.1 : CertificateTable
DD 0                    ;  5.2 : Size
DD 0                    ;  6.1 : BaseRelocationTable
DD 0                    ;  6.2 : Size
DD 0                    ;  7.1 : Debug
DD 0                    ;  7.2 : Size
DD 0                    ;  8.1 : Architecture
DD 0                    ;  8.2 : Size
DD 0                    ;  9.1 : GlobalPtr
DD 0                    ;  9.2 : Zero
DD 0                    ; 10.1 : TLSTable
DD 0                    ; 10.2 : Size
DD 0                    ; 11.1 : LoadConfigTable
DD 0                    ; 11.2 : Size
DD 0                    ; 12.1 : BoundImport
DD 0                    ; 12.2 : Size
DD 0                    ; 13.1 : IAT
DD 0                    ; 13.2 : Size
DD 0                    ; 14.1 : DelayImportDescriptor
DD 0                    ; 14.2 : Size
DD 0                    ; 15.1 : CLRRuntimeHeader
DD 0                    ; 15.2 : Size
DQ 0                    ; 16   : Reserved (must be zero)

Header.Optional.end:

Header.COFF.SectionTable.begin:

DB ".text"              ; Name (Size < 8 bytes)
ALIGN 8, DB 0
DD Section.text.vsize   ; VirtualSize
DD Section.text.vstart  ; VirtualAddress
DD Section.text.size    ; SizeOfRawData
DD Section.text.start   ; PointerToRawData
DD 0                    ; PointerToRelocations
DD 0                    ; PointerToLinenumbers
DW 0                    ; NumberOfRelocations
DW 0                    ; NumberOfLinenumbers
DD Section.text.char    ; Characteristics

DB ".rdata"             ; Name (Size < 8 bytes)
ALIGN 8, DB 0
DD Section.rdata.vsize  ; VirtualSize
DD Section.rdata.vstart ; VirtualAddress
DD Section.rdata.size   ; SizeOfRawData
DD Section.rdata.start  ; PointerToRawData
DD 0                    ; PointerToRelocations
DD 0                    ; PointerToLinenumbers
DW 0                    ; NumberOfRelocations
DW 0                    ; NumberOfLinenumbers
DD Section.rdata.char   ; Characteristics

Header.COFF.SectionTable.end:

Header.end:

SECTION .text START=Section.text.start VSTART=Section.text.vstart

Section.text.begin:

%DEFINE EFI_HANDLE       rcx
%DEFINE EFI_SYSTEM_TABLE rdx

sub rsp, 32 + 8
mov rcx, [EFI_SYSTEM_TABLE + 0x40] ; EFI_SYSTEM_TABLE.EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL
lea rdx, [rel HelloWorld]
call [rcx + 0x08]                  ; EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.EFI_TEXT_OUTPUT_STRING
jmp $

Section.text.end:

SECTION .rdata START=Section.rdata.start VSTART=Section.rdata.vstart

Section.rdata.begin:

HelloWorld:
DW __?utf16?__("Hello, World!"), 0

Section.rdata.end:

DB 0x200 - ($ - $$) DUP 0
