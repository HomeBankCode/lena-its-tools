## Introduction:
This python script takes all the .its files from current folder and removes information that might be used to identify the child, based on the user's selections. 
It will generate a new folder named "output" in the current location with modified .its files in it. 
It will also generate a report spreadsheet as "overview.csv". All changes that happen to these .its files will be showed in this overview file. For example, if one entry in .its file is deleted, it will show the original value for this entry. If one entry is changed to a dummy value, it will show the original value and new value. 

## Usage:
Put the "its_anonymize.py" in a folder with .its files you want to process. Then run this python script.
If you have any problem with software dependency , please refer to this [readme](https://github.com/babylanguagelab/public-scripts).

## Configuration:
Based on different purposes, this script is designed to be configurable. At beginning of this script, you will see some sentences like this:
```python
CONF_DICT = {
    "Serial Number": [2, "0000"],
    "Gender": [0, -1],
    "Algorithm Age": [0, -1],
    "Child ID": [2, "0000"],
    "Child Key": [2, "0000000000000000"],
    "Enroll Date": [1, -1],
    "DOB": [2, "2000-01-01"],
    "Time Zone": [1, -1],
    "UTC Time": [1, -1],
    "Clock Time": [2, "0"]
}
```
The first part before colon is name of entry in .its file. The second part in square bracket is configuration. The first number in configuration stands for behaviour for this entry.
- 0 --> no change.
- 1 --> delete.
- 2 --> use dummy value.

The second number in configuration stands for dummy value.

Here are some explanations for each entry:
- Serial Number: "This is the serial number of the DLP. Fuzz replaces the value with random or specified new values."
- Algorithm Age: This is a value used by LENA in its processing of the UPL files. It is not an exact age.
- Child ID: Depending on your participant labeling system, you may or may not want to fuzz this. Fuzz replaces the value with random or specified new values.
- Child Key: Depending on your participant labeling system, you may or may not want to fuzz this. Fuzz replaces the value with random or specified new values.
- Enroll Date: This is the date the child was input into LENA's system. If you are anonymizing the dates, it is important to delete this.
- DOB & Clock Time: Fuzz replaces the value of DOB with random or specified new values. Default is January 1, 2000. Clock time for each its file will be calculated based on this new Fuzz'ed value and the child's original age.
