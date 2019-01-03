# Compare two files and get the differences between the two.
# It accepts two text files.
# Compare-Object: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/compare-object?view=powershell-6

# Parameter:
#  Required
#  -operation differences: Output lists only the differences between the files
#  -operation matches: Output lists only the matches between the files
Param([Parameter(Mandatory = $true)]
    [String] $operation = $args[0])

# Get the contents of the two files
$file1 = Get-Content inputs\file1.txt
$file2 = Get-Content inputs\file2.txt

# PassThru command omits the PSCustomObject wrapper around the compared objects and returns the differing
# objects, unchanged.
if ($operation -eq 'differences')
{
    $diffs = Compare-Object -ReferenceObject $file1 -DifferenceObject $file2 -PassThru
    $diffs | Out-File outputs\output.txt
} elseif ($operation -eq 'matches') {
    $matches = Compare-Object -ReferenceObject $file1 -DifferenceObject $file2 -PassThru -ExcludeDifferent -IncludeEqual
    $matches | Out-File outputs\output.txt
}