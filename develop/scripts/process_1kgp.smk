#!/usr/bin/env python
# -*- coding: utf-8 -*-

__author__ = "Alba Refoyo Martinez"
__copyright__ = "Copyright 2024, University of Copenhagen"
__email__ = "gsd818@@ku.dk"
__license__ = "MIT"

import pandas as pd


rule all:
    input:
        expand("results/all_{gender}.txt", gender=["female"])

rule preprocess:
    input:
        "samples_1kgp.tsv"
    output:
        tsv="samples_1kgp_cleaned.tsv"
    run:
        df = pd.read_csv(input[0], sep='\t') # Read tsv
        df_cleaned = df.dropna() # remove missing 
        df_cleaned.to_csv(output[0], sep='\t', index=False) # save to file

rule split_by_superpop:
    input:
        "samples_1kgp_cleaned.tsv"
    output:
        "results/{superpop}.tsv"
    run:
        df = pd.read_csv(input[0], sep='\t') # Read tsv
        df_superpop = df[df['super_pop'] == wildcards.superpop] # filter by superpop
        df_superpop.to_csv(output[0], sep='\t', index=False) # save to file

rule combine:
    input:
        expand("results/{superpop}.tsv", superpop=["EUR", "EAS", "AFR", "AMR", "SAS"], allow_missing=True)
    output:
        txt="results/all_{gender}.txt"
    shell:
        """
        cat {input} | awk -F'\t' '$4 == "{wildcards.gender}"' > {output.txt}
        """
        