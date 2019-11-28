# IdentAT

IdentAT is usable only on IBM PC/AT computers (IBM Model 5170).
It will identify whether the computer in question is a Type 1, Type 2, or Type 3,
corresponding to the three motherboard and BIOS revisions that IBM produced.

The source code is compatible with Microsoft Macro Assembler 6.0.

The executable file is IDENTAT.COM, and also provided is a bootable 1.2M 5.25" floppy disk image (IDAT525.IMA). If you use the bootable image, it will automatically run IDENTAT.COM once bootup is complete.

## Building

This has been built with Microsoft Macro Assembler 6.0. An NMAKE makefile is provided; in order to use it, type:

NMAKE

in the root of the distribution directory.

To build manually, type:

ML /AT IDENTAT.ASM

in the root of the distribution directory.

## License

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>