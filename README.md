# ECG Signal Processing in MATLAB

This project analyzes electrocardiogram (ECG) signals using MATLAB to extract cardiovascular metrics.

## Features
- ECG signal filtering using bandpass filter (0.5–40 Hz)
- Automatic R-peak detection
- Heart rate calculation
- Heart Rate Variability (HRV) metrics
  - SDNN
  - RMSSD
  - pNN50

## Method
1. Import ECG data from CSV
2. Apply bandpass filtering to remove noise
3. Detect R-peaks using MATLAB `findpeak`
4. Compute RR intervals
5. Calculate heart rate and HRV metrics

## Example Output
- Filtered ECG signal
- Detected R-peaks
- Average heart rate
- HRV statistics

## Tools Used
- MATLAB
- Signal processing techniques
