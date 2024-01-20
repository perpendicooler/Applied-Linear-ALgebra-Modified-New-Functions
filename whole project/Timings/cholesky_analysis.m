    clc;
    clear all;
    %% Code Start form here
    %Measure  n = [100:100:2000]
    n_values = [100:100:2000];
    execution_times = zeros(size(n_values));
   
    for i = 1:length(n_values)
        
        A = randn(n_values(i));
        A = A * A'; 
        A = A + n_values(i) * eye(n_values(i)); 

        try
            timing = timeit(@() chol(A));
            execution_times(i) = timing;
        catch
            fprintf('Error for n = %d. Matrix is not positive definite.\n', n_values(i));
            execution_times(i) = NaN; 
        end
    end

    
    % Fit cubic polyfit
    degree = 3;
    [p, S, mu] = polyfit(n_values, execution_times, degree);

    %Predict results
    n_values_all = [100:100:2000];
    n_values_extra = [150:100:1550];

    predict_time = polyval(p, n_values_all, S, mu);
    predict_times_extra = polyval(p, n_values_extra, S, mu);

    figure;
    plot(n_values, execution_times, 'o','LineWidth', 1, 'MarkerSize', 8, 'Color', 'red', 'DisplayName', 'Measured Times');
    hold on;
    plot(n_values_all, predict_time, '-','LineWidth', 1, 'MarkerSize', 8, 'Color', 'green', 'DisplayName', 'Cubic Fit');

    % Add the predicted times for the extra values 
    plot(n_values_extra, predict_times_extra, 'x','LineWidth', 1, 'MarkerSize', 8, 'Color', 'blue', 'DisplayName', 'Predicted Times (Extra)');
    grid on;

    xlabel('Matrix Size ');
    ylabel('Execution Time ');
    title('Cholesky Decomposition Execution Time Analysis');
    legend('Location', 'SouthEast');

    % Trying polynomial degrees (2 and 4)
    plynomial_2 = 2;
    plynomial_4 = 4;

    [p_2, S_2, mu_2] = polyfit(n_values, execution_times, plynomial_2);
    [p_4, S_4, mu_4] = polyfit(n_values, execution_times, plynomial_4);

    predict_times_2 = polyval(p_2, n_values_all, S_2, mu_2);
    predict_times_4 = polyval(p_4, n_values_all, S_4, mu_4);

    %results for degree measured timed
    figure
    plot(n_values, execution_times, 'o', 'DisplayName', 'Measured Times');
    grid on;
    hold on;
    plot(n_values_all, predict_time, '-','LineWidth', 1, 'MarkerSize', 8, 'Color', 'red', 'DisplayName', 'Cubic Fit');
    xlabel('Matrix Size');
    ylabel('Execution Time');
    title('Cholesky Decomposition Execution Time Analysis');
    legend('Location', 'SouthEast');
    %  results for degree 2 and degree 4
    figure;
    plot(n_values, execution_times, 'o', 'DisplayName', 'Measured Times');
    grid on;
    hold on;
    plot(n_values_all, predict_time, '-','LineWidth', 1, 'MarkerSize', 8, 'Color', 'red', 'DisplayName', 'Cubic Fit');
    plot(n_values_all, predict_times_2, '--','LineWidth', 1, 'MarkerSize', 8, 'Color', 'green', 'DisplayName', 'Degree 2 Fit');
    plot(n_values_all, predict_times_4, '-.','LineWidth', 1, 'MarkerSize', 8, 'Color','blue', 'DisplayName', 'Degree 4 Fit');

    xlabel('Matrix Size');
    ylabel('Execution Time');
    title('Cholesky Decomposition Execution Time Analysis with polynomial 2 and 4');
    legend('Location', 'SouthEast');
