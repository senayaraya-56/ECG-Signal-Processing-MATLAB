# ECG Signal Processing & Analysis Pipeline (MATLAB + SQL)

This project implements a complete ECG data processing pipeline, combining signal processing in MATLAB with structured data analysis using SQL.
Data Input → Signal Processing → Feature Extraction → Data Storage → SQL Analysis

## Overview
The system processes multiple ECG datasets, extracts cardiovascular metrics, stores results in a structured table, and performs higher-level statistical and clinical classification using SQL queries.

## Key Features
- Batch processing of multiple ECG datasets
- Bandpass filtering (0.5–40 Hz) for noise removal
- Automatic R-peak detection
- Heart rate and HRV computation
- Export of processed results to CSV
- SQL-based analytical layer for classification and insights

## Signal Processing Pipeline (MATLAB)
1. Import ECG data from CSV files
2. Apply bandpass filtering
3. Detect R-peaks using `findpeaks`
4. Compute RR intervals
5. Extract metrics:
   - Average Heart Rate (Avg_HR)
   - SDNN (Standard Deviation of NN intervals)
   - RMSSD (Root Mean Square of Successive Differences)
   - pNN50

## Data Engineering Component
- Aggregates results from multiple ECG recordings into a single dataset
- Exports results to CSV for downstream analysis
- Structured format enables integration with databases

## SQL Analysis Layer
The processed dataset is analyzed using SQL to derive clinical insights:

- Heart rate classification:
  - Bradycardia (< 60 bpm)
  - Normal (60–100 bpm)
  - Tachycardia (> 100 bpm)

- HRV categorization:
  - Low HRV
  - Moderate HRV
  - High HRV

- Stress Index calculation:
  - Defined as Avg_HR / SDNN
