# ByteSearch
A utility to recursively scan a folder of files for a known byte string.

This utility will recursively scan through a folder (and all of its subfolders) to find any files containing a specific byte-string, or the contents of a specific binary file.

## Current Version
ByteSearch is currently at version [1.1](https://github.com/DerekPascarella/ByteSearch/raw/main/byte_search.exe).

## Generic Usage
```
byte_search --source_type <file|string> --source <path_to_file|byte_string> --target <path_to_folder>
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

## Example Output
```
PS C:\> .\byte_search.exe --source_type string --source 8140814082BD82D182C2 --target C:\path

ByteSearch v1.0
Written by Derek Pascarella (ateam)

> Gathering list of all files in target scan folder...

> Initiating scan process against 11 files...

> Match found!
  C:\path\subfolder\1ST_READ.BIN

> Scan complete! Found 1 match total.
```
