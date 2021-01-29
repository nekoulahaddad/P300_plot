clc; close all; clear;
result_p300_all = xlsread('P300.xlsx'); 
result_no_p300_all = xlsread('NoP300.xlsx');

result_p300_all = result_p300_all';
result_no_p300_all = result_no_p300_all';
result_ratio_p300_no_p300 = result_p300_all./result_no_p300_all;
result_difference_p300_no_p300 = result_p300_all-result_no_p300_all;

number_of_signals_correlation = 3; 
the_choosen_signal = [1 7 4];
frequency = [string('1HZ'),string('3HZ'),string('5HZ')];
correlation_limit_size = 100;
best_points = max(result_difference_p300_no_p300');
best_1HZ = find(result_difference_p300_no_p300(1,:) == best_points(1));
best_3HZ = find(result_difference_p300_no_p300(2,:) == best_points(2));
best_5HZ = find(result_difference_p300_no_p300(3,:) == best_points(3));
fprintf('best point for 1Hz is %f\n',best_1HZ);
fprintf('best point for 3Hz is %f\n',best_3HZ);
fprintf('best point for 5Hz is %f\n',best_5HZ);
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
    figure
    plot(number_of_correlations,result_difference_p300_no_p300(kj,:),'b');
    title(frequency(kj))
    xlabel('correlation variant')
    ylabel('difference between P300 and NoP300')
end;
number_of_points = [50 100 200 500 1000 1500 2000 2500 5000 10000];
correlation_limit_size = 50;
element_number = 1;
best_parameters_1HZ = 0;
best_parameters_3HZ = 0;
best_parameters_5HZ = 0;
for qqrrr = 1:correlation_limit_size/5
    for qqrr = 1:correlation_limit_size
        for qqr=-correlation_limit_size:-1
            if element_number == best_1HZ 
                best_parameters_1HZ = [qqr qqrr qqrrr];
            elseif element_number == best_3HZ 
                best_parameters_3HZ = [qqr qqrr qqrrr];
            elseif element_number == best_5HZ 
                best_parameters_5HZ = [qqr qqrr qqrrr];
            end;
            element_number = element_number + 1;
        end;
    end;
end;
best_parameters = [best_parameters_1HZ;best_parameters_3HZ;best_parameters_5HZ];
for uiu=1:3
[psi,xval] = morlet(best_parameters(uiu,1),best_parameters(uiu,2),number_of_points(best_parameters(uiu,3)));
figure
plot(xval,psi)
title(frequency(uiu))
end;



