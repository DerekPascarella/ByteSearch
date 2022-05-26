#!/usr/bin/perl
#
# ByteSearch v1.0
# Written by Derek Pascarella (ateam)
#
# A utility to recursively scan a folder of files for a known byte string.

# Use strict policy on syntax and data-types.
use strict;

# Include necessary modules.
use File::Find;
use Getopt::Long;

# Our arguments.
my $source_type;
my $source;
my $target;

# Our variables.
my @files;
my $error;
my $bytes_source;
my $bytes_target;
my $match_count = 0;

# Define our parameters and arguments.
GetOptions(
	'source_type=s' => \$source_type,
	'source=s' => \$source,
	'target=s' => \$target
);

# Convert applicable arguments to lowercase.
$source_type = lc($source_type);

# Invalid source-type option specified.
if($source_type ne "file" && $source_type ne "string")
{
	$error = "Invalid source-type specified (valid options are \"file\" and \"string\").";
	&show_error($error);
}
# User is searching by file and source file doesn't exist or isn't readable.
elsif($source_type eq "file" && (!-e $source || !-R $source))
{
	$error = "Source file does not exist or isn't readable.";
	&show_error($error);
}
# User is searching by string but did not specify one.
elsif($source_type eq "string" && $source eq "")
{
	$error = "No source byte-string specified.";
	&show_error($error);
}
# Target search folder does not exist or isn't readable.
elsif(!-e $target || !-R $target)
{
	$error = "Target folder to scan does not exist or isn't readable.";
	&show_error($error);
}

# Print status message.
print "\nByteSearch v1.0\n";
print "Written by Derek Pascarella (ateam)\n\n";
print "> Gathering list of all files in target scan folder...\n\n";

# If searching by string, store source byte-string in "bytes_source".
if($source_type eq "string")
{
	# Convert byte-string to uppercase and remove whitespace.
	($bytes_source = uc($source)) =~ s/\s+//g;
}
# Otherwise, read source file and store its contents in "bytes_source".
elsif($source_type eq "file")
{
	# Convert byte-string to uppercase and remove whitespace.
	($bytes_source = uc(&read_bytes($source, (stat $source)[7]))) =~ s/\s+//g;
}

# Remove trailing double-quotation mark from target path if present from a known issue with PowerShell.
if(substr($target, -1) eq "\"" || substr($target, -1) eq "\\")
{
	$target = substr($target, 0, -1);
}

# Recursively iterate through all files and folder in target folder and store each as an index of
# "files".
find(sub { push @files, $File::Find::name unless -d; }, $target);

# Print status message.
print "> Initiating scan process against " . scalar(@files) . " files...\n\n";

# Iterate through each element of "files", checking each one for match against source.
foreach(@files)
{
	# Store target byte-string and convert it to uppercase and remove whitespace.
	($bytes_target = uc(&read_bytes($_, (stat $_)[7]))) =~ s/\s+//g;

	# Source byte-string was found in target file.
	if($bytes_target =~ $bytes_source)
	{
		# Correct forward slash.
		if($^O =~ "MSWin")
		{
			$_ =~ s/\//\\/g;
		}
		
		# Print status message.
		print "> Match found!\n";
		print "  $_\n\n";

		# Increase match count by one.
		$match_count ++;
	}
}

# Print status message.
print "> Scan complete! Found " . $match_count . " match";

# Continue status message.
if($match_count > 1)
{
	print "es";
}

# Finish status message.
print " total.\n\n";

# Subroutine to throw a specified exception.
#
# 1st parameter - Error message with which to throw exception.
sub show_error
{
	my $error = $_[0];

	die "ByteSearch v1.0\nWritten by Derek Pascarella (ateam)\n\n$error\n\nUsage: byte_search --source_type <file|string> --source <path_to_file|byte_string> --target <path_to_folder>\n";
}

# Subroutine to read a specified number of bytes (starting at the beginning) of a specified file,
# returning hexadecimal representation of data.
#
# 1st parameter - Full path of file to read.
# 2nd parameter - Number of bytes to read.
sub read_bytes
{
	my $file_to_read = $_[0];
	my $bytes_to_read = $_[1];

	open my $filehandle, '<:raw', "$file_to_read" or die $!;
	read $filehandle, my $bytes, $bytes_to_read;
	close $filehandle;
	
	return unpack 'H*', $bytes;
}