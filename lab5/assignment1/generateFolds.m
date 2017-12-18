function fold = generateFolds()
    a_data = load('data_lvq_A');
    a_data = a_data.matA;

    b_data = load('data_lvq_B');
    b_data = b_data.matB;

    % Create fold struct
    fold = struct;
    fold.a_dat = [];
    fold.b_dat = [];

    % Generate random permutations of indices. 
    a_idx = randperm(length(a_data));
    b_idx = randperm(length(b_data));

    % folds = zeros(length(a_data) + length(b_data),5);
    % Assign to folds
    for foldidx = 1:10
        local_idx = (foldidx - 1) * 10;
        local_idx = local_idx + (1:10);

        fold(foldidx).a_dat = a_data(a_idx(local_idx),:);
        fold(foldidx).b_dat = b_data(b_idx(local_idx),:);
    end
end