#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pandas as pd
import argparse

def filter_year(input_file, output_file, year):
    # Read the input file into a DataFrame
    df = pd.read_csv(input_file, sep='\t')

    # Filter the DataFrame based on the 'year' column
    df_filtered = df[df['year'] >= year]

    # Save the filtered DataFrame to the output file
    df_filtered.to_csv(output_file, sep='\t', index=False)

if __name__ == "__main__":
    # Set up argument parsing
    parser = argparse.ArgumentParser(description="Filter input data by year.")
    parser.add_argument('-i', '--input', required=True, help='Input file path')
    parser.add_argument('-o', '--output', required=True, help='Output file path')
    parser.add_argument('-y', '--year', type=int, required=True, help='Year to filter by')

    # Parse the command-line arguments
    args = parser.parse_args()

    # Call the filter function with the parsed arguments
    filter_year(args.input, args.output, args.year)