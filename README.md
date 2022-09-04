# ByteSearch
A utility to recursively scan a folder of files for a known byte-string.

This utility will recursively scan through a folder (and all of its subfolders) to find any files containing a specific byte-string, or the contents of a specific binary file.

## Latest Version
ByteSearch is currently at version [1.2](https://github.com/DerekPascarella/ByteSearch/raw/main/byte_search.exe).

## Changelog
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
byte_search --source_type <file|string> --source <path_to_file|byte_string> --target <path_to_folder>
```
Quick mode, which assumes `--source_type` as `string` and `--target` as the current working directory.
```
byte_search --quick <string>
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

## Example Output
```
PS C:\> .\byte_search.exe --source_type string --source 8140814082BD82D182C2 --target C:\path

ByteSearch v1.2
Written by Derek Pascarella (ateam)

> Gathering list of all files in target scan folder...

> Initiating scan process against 11 files...

> Match found (offset 0x1F4):
  C:\path\subfolder\1ST_READ.BIN

> Scan complete! Found 1 match total.
```
