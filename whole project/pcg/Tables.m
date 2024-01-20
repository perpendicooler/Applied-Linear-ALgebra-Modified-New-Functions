% Initialize a table to store the results
results_table = table('Size', [num_experiments, 4], 'VariableTypes', {'double', 'double', 'double', 'double'}, ...
    'VariableNames', {'Relative_Balance', 'Relative_Error', 'Iterations', 'Execution_Time'});

% Experiment 1: No presetting
results_table(1, :) = [relres1, errvec1(end), iter1, time1];

% Experiment 2: Presetting with incomplete Cholesky (IC(0))
results_table(2, :) = [relres2, errvec2(end), iter2, time2];

% Experiment 3: Custom pre-conditioner (replace with your own pre-conditioner)
results_table(3, :) = [relres3, errvec3(end), iter3, time3];

% Display the results table
disp('Results Summary:');
disp(results_table);
