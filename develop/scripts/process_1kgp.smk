#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = "Alba Refoyo Martinez"
__copyright__ = "Copyright 2024, University of Copenhagen"
__email__ = "gsd818@@ku.dk"
__license__ = "MIT"


import pandas as pd


rule all:
    input:
        expand("results/all_{sex}.txt", sex=["female"])

rule preprocess:
    """
    Remove missing from metadata
    """
    input:
        "data/samples_1kgp.tsv"
    output:
        tsv="results/samples_1kgp_cleaned.tsv"
    run:
        df = pd.read_csv(input[0], sep='\t') # Read tsv
        df_cleaned = df.dropna() # remove missing 
        df_cleaned.to_csv(output[0], sep='\t', index=False) # save to file

rule split_by_superpop:
    """
    Filter the metadata by superpopulation assignments
    """
    input:
        "results/samples_1kgp_cleaned.tsv"
    output:
        "results/{superpop}.tsv"
    threads: 1
    run:
        df = pd.read_csv(input[0], sep='\t') # Read tsv
        df_superpop = df[df['super_pop'] == wildcards.superpop] # filter by superpop
        df_superpop.to_csv(output[0], sep='\t', index=False) # save to file

rule combine:
    """
    Concatenate files based on sex
    """
    input:
        expand("results/{superpop}.tsv", superpop=["EUR", "EAS", "AFR", "AMR", "SAS"])
    output:
        txt="results/all_{sex}.txt"
    shell:
        """
        cat {input} | awk -F'\t' '$4 == "{wildcards.sex}"' > {output.txt}
        """
        
