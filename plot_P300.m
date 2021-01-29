result_p300_all = xlsread('P300.xlsx'); 
result_no_p300_all = xlsread('NoP300.xlsx');

result_p300_all = result_p300_all';
result_no_p300_all = result_no_p300_all';
result_ratio_p300_no_p300 = result_p300_all./result_no_p300_all;

number_of_signals_correlation = 3; 
the_choosen_signal = [1 7 4];
frequency = [string('1HZ'),string('3HZ'),string('5HZ')];
correlation_limit_size = 100;


number_of_correlations = 1:25000;
for kj=1:3
    figure
    hold on
    plot(number_of_correlations,result_p300_all(kj,:),'r','LineWidth',2);
    plot(number_of_correlations,result_no_p300_all(kj,:),'b');
    title(frequency(kj))
    xlabel('correlation variant')
    ylabel('maximum value of correlation')
    legend('P300','noP300')
    hold off
    figure
    plot(number_of_correlations,result_ratio_p300_no_p300(kj,:),'b');
    title(frequency(kj))
    xlabel('correlation variant')
    ylabel('Ratio P300/NoP300')
    legend('P300','noP300')
end;