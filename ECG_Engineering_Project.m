clc
clear
close all

%% Senay Araya
% ECG_Engineering_Project

data1 = readmatrix('data/e0103.csv');  % change file name as needed
data2 = readmatrix('data/e0110.csv');   % change file name as needed
data3 = readmatrix('data/e0124.csv');  % change file name as needed
ecg1 = data1(:,1); %In case the file has multiple columns, It selects the data from the first which is typically the Voltage column.
ecg2 = data2(:,1);
ecg3 = data3(:,1);
ecg_cell = {ecg1,ecg2,ecg3} ;
n = numel(ecg_cell) ; %y will be the number of arrays ECG's being analyzed.
fs = 360; % sampling rate (Change if needed)
for i = 1:n
    ecg = ecg_cell{i};
    t = (0:length(ecg)-1)/fs;
    figure (2*i-1)
    %Plot the data unfiltered
    plot(t,ecg) 
    xlabel('Time (s)'); ylabel('Amplitude'); title(['Unfiltered ECG signal', num2str(i)])
    %Remove noise using bandpass filter
    t = t(200:end-200); %File needs to be the same size
    ecg_filtered = bandpass(ecg,[0.5 40],fs); %Removing Noise using a filter
    ecg_filtered = ecg_filtered(200:end-200); %Since their were a lot of artifact noise at the beginning and end, I those parts of the data out.

    %Plot
    figure (2*i)
    plot(t,ecg_filtered)
    xlabel('Time (s)'); ylabel('Amplitude'); title(['Filtered ECG Signal',num2str(i)]) 


    [peaks,locs] = findpeaks(ecg_filtered, ... 
        'MinPeakDistance',0.3*fs, ...
        'MinPeakHeight',0.3*max(ecg_filtered), ...
        'MinPeakProminence', 0.25) ;
    %Stores the peaks amplitude and the sample at which the peak occured into the two arrays. (peaks and locs)
    %The distance between peaks should be atleast 0.3 seconds. Otherwise the code will recognize the same peak twice.

    hold on
    plot(t(locs),peaks,'ro')
    legend('ECG','R Peaks')

    RR_intervals = diff(locs)/fs; % Calculates the distance between locs next to eachother and converts them seconds.
    heart_rate = 60./RR_intervals; % Heart rate is typically measured in beats per minute, so we did that.

    avg_HR(i) = mean(heart_rate); % Takes the average of all the Heart rate values.

    SDNN(i) = std(RR_intervals); %SDNN – Standard deviation of peaks
    RMSSD(i) = sqrt(mean(diff(RR_intervals).^2)); %RMSSD – Root mean square of peaks 
    NN50(i) = sum(abs(diff(RR_intervals)) > 0.05); 
    pNN50(i) = (NN50(i)/length(RR_intervals))*100; %pNN50 % of RR differences > 50 ms

end

fprintf('Average Heart Rate: %.2f BPM\n', avg_HR);
fprintf('SDNN: %.4f s\n', SDNN);
fprintf('RMSSD: %.4f s\n', RMSSD);
fprintf('pNN50: %.2f %%\n', pNN50);
ECG_num = (1:n)';

T = table(ECG_num, avg_HR', SDNN', RMSSD', pNN50', ...
    'VariableNames', {'ECG', 'Avg_HR', 'SDNN', 'RMSSD', 'pNN50'});
disp(T)
writetable(T, 'ECG_Summary.csv') %Create an csv file with the summarized data table.
