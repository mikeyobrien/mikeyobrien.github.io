+++
title = "Markdown Table <-> CSV"
author = ["Mikey O'Brien"]
date = "2023-08-22"
tags = ["TIL"]
categories = ["scripting"]
draft = false
+++

Yesterday, I found myself needing to convert between a markdown and CSV table
and vice versa. A quick Google search didn't turn up anything capable of doing
so. Tools either converted one way or were online only (offline was a hard
requirement). I'm sure with enough digging, I could have found something, but I
just needed something quickly that worked.

A few GPT-4 prompts later, and I had a quick working solution.

```python
#!/usr/bin/env python3

import sys
import re
import csv

def markdown_to_csv(markdown_table):
    lines = markdown_table.strip().split('\n')
    if set(lines[1]) == {'-', '|', ' '}:
        del lines[1]
    lines = [re.sub(' +', ' ', line.strip()).split('|') for line in lines]
    lines = [[cell.strip() for cell in line if cell] for line in lines]
    lines = [['"{}"'.format(cell) if ',' in cell else cell for cell in line] for line in lines]
    csv_table = '\n'.join([','.join(line) for line in lines])
    return csv_table

def csv_to_markdown(csv_table):
    reader = csv.reader(csv_table.strip().split('\n'))
    lines = [line for line in reader]
    # Find the maximum width for each column
    col_widths = [max(len(str(cell)) for cell in col) for col in zip(*lines)]
    # Apply padding to each cell to match the column width
    lines = [[' ' + str(cell).ljust(width) + ' ' for cell, width in zip(line, col_widths)] for line in lines]
    # Add a separator line
    separator = ['-' * width for width in col_widths]
    lines.insert(1, separator)
    # Convert to markdown table
    markdown_table = '\n'.join(['|' + '|'.join(line) + '|' for line in lines])
    return markdown_table

if __name__ == "__main__":
    input_data = sys.stdin.read()
    # Detect if the input is CSV or markdown based on the presence of the pipe character
    if '|' in input_data:
        output_data = markdown_to_csv(input_data)
    else:
        output_data = csv_to_markdown(input_data)
    print(output_data)
```
https://gist.github.com/mikeyobrien/e77f53f28a885e3d0c202331cb60dfca

Using the tool is simple,
```sh
# Make executable
chmod +x table_format_converter.py

# Replace the table in your clipboard with converted table.
# The script will automatically detect and convert accordingly.
pbpaste | ./table_format_converter.py | pbcopy
```