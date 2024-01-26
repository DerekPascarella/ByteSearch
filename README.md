# ByteSearch
A utility to recursively scan a folder of files for a known byte-string.

This utility will recursively scan through a folder (and all of its subfolders) to find any files containing a specific byte-string, or the contents of a specific binary file.

## Current Version
ByteSearch is currently at version [1.7](https://github.com/DerekPascarella/ByteSearch/raw/main/byte_search.exe).

## Changelog
* Version 1.7 (2024-01-26)
  * Added `--ignore` option to omit a list of file extensions from search.
* Version 1.6 (2023-01-20)
  * Multiple matches within a single file are now grouped for better readability.
* Version 1.5 (2023-01-19)
  * Fixed bug ignoring matches.
* Version 1.4 (2022-11-21)
  * Fixed bug returning erroneous search matches.
* Version 1.3 (2022-11-11)
  * Added support for returning multiple matches found in a single file.
* Version 1.2 (2022-08-30)
  * Fixed bug in implementation of `--quick` option.
* Version 1.1 (2022-08-29)
  * Added `--quick` option.
  * Match results now display offset of searched byte-string.
* Version 1.0 (2022-05-26)
  * Initial release.

## Generic Usage
Standard mode, with customizable options.
```
byte_search --source_type <file|string> --source <path_to_file|byte_string> --target <path_to_folder> [--ignore <comma_separated_file_extensions>]
```
Quick mode, which assumes `--source_type` as `string` and `--target` as the current working directory.
```
byte_search --quick <byte_string> [--ignore <comma_separated_file_extensions>]
```


## Example Usage
Search the folder `C:\path` for any files containing the byte-string `8140814082BD82D182C2`:
```
byte_search --source_type string --source 8140814082BD82D182C2 --target C:\path
```
Search the folder `C:\path` for any files containing the contents of the file `C:\files\source.bin` (e.g., embedded in a container/archive):
```
byte_search --source_type file --source C:\files\source.bin --target C:\path
```
Search current working directory for any files containing the byte-string `50565254`:
```
byte_search --quick 50565254
```
Search current working directory for any files containing the byte-string `50565254`, omitting files with extension .abc and .xyz:
```
byte_search --quick 50565254 --ignore abc,xyz
```


## Example Output
```
PS C:\> .\byte_search.exe --source_type string --source 8140814082BD82D182C2 --target C:\path

ByteSearch v1.7
Written by Derek Pascarella (ateam)

> Gathering list of all files in target scan folder...

> Initiating scan process against 4 files...

> 1ST_READ.SH2
  - Offset 0x49344

> MESSAGE.TK3
  - Offset 0x5C6

> PREFILE.TK3
  - Offset 0x5C6
  - Offset 0x110A0
  - Offset 0x1110B
  - Offset 0x117D1
  - Offset 0x13236
  - Offset 0x159D3
  - Offset 0x15A3E
  - Offset 0x16042
  - Offset 0x16DF9
  - Offset 0x17D34

> TK3ROOT.SH2
  - Offset 0x49344

> Scan complete! Found 13 matches total.
```
