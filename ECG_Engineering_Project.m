clc
clear
close all

%% Senay Araya
% ECG_Engineering_Project
data = readmatrix('e0103.csv');  % change file name as needed
ecg = data(:,1); %In case the file has multiple columns, It selects the data from the first which is typically the important column for this analysis

fs = 360; % sampling rate (Change if needed)
t = (0:length(ecg)-1)/fs;
figure (1)
%Plot the data unfiltered
plot(t,ecg) 
xlabel('Time (s)'); ylabel('Amplitude'); title('Unfiltered ECG signal')


%Remove noise using bandpass filter

ecg_filtered = bandpass(ecg,[0.5 40],fs); %Removing Noise using a filter
ecg_filtered = ecg_filtered(200:end-200); %Since their were a lot of artifact noise at the beginning and end, I those parts of the data out.
t = t(200:end-200); %File needs to be the same size

%Plot
figure (2)
plot(t,ecg_filtered)
xlabel('Time (s)'); ylabel('Amplitude'); title('Filtered ECG Signal') 


[peaks,locs] = findpeaks(ecg_filtered, ... 
    'MinPeakDistance',0.3*fs, ...
    'MinPeakHeight',0.3*max(ecg_filtered), ...
    'MinPeakProminence', 0.25) ;
%Stores the peaks amplitude and the sample at which the peak occured into the two arrays. (peaks and locs)
%The distance between peaks should be atleast 0.7 seconds. Otherwise the code will recognize the same peak twice.

hold on
plot(t(locs),peaks,'ro')
legend('ECG','R Peaks')

RR_intervals = diff(locs)/fs; % Calculates the distance between locs next to eachother and converts them seconds.
heart_rate = 60./RR_intervals; % Heart rate is typically measured in beats per minute, so we did that.

avg_HR = mean(heart_rate); % Takes the average of all the Heart rate values.

SDNN = std(RR_intervals); %SDNN – Standard deviation of RR intervals
RMSSD = sqrt(mean(diff(RR_intervals).^2)); %RMSSD – Root mean square of successive differences
NN50 = sum(abs(diff(RR_intervals)) > 0.05); 

pNN50 = (NN50/length(RR_intervals))*100; %pNN50 – % of RR differences > 50 ms




fprintf('Average Heart Rate: %.2f BPM\n', avg_HR);
fprintf('SDNN: %.4f s\n', SDNN);
fprintf('RMSSD: %.4f s\n', RMSSD);
fprintf('pNN50: %.2f %%\n', pNN50);
