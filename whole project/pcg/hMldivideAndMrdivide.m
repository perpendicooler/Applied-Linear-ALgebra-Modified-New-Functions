function varargout = hMldivideAndMrdivide(transposeFlagA, A, B, throwMrdivideErrors)
%hMldivideAndMrdivide is a common implementation of mldivide and mrdivide
%   for (co)distributed matrices. Optional second output is reciprocal
%   condition number (rCond).
%   


%   Copyright 2012-2019 The MathWorks, Inc.

nargoutchk(1, 2);

% Initialize varargout{2} = rCond with empty if required
if nargout>1
    varargout{2} = [];
end

% Treat logicals and chars as doubles
if ischar(A) || islogical(A)
    A = double(A);
end
if ischar(B) || islogical(B)
    B = double(B);
end

sizeA = size(A);
if isa(A, 'codistributed')
    iErrorForIncompatibleDimension(A, B, transposeFlagA);
    
    if sizeA(1) == sizeA(2) % Square case
        % Check whether A has a special structure to use the most efficient solver
        matrixType = getFillPattern(A);
        
        aDist = getCodistributor(A);
        if strcmp(matrixType, 'Diagonal') % Solver for diagonal matrix (sparse and dense)
            [varargout{1:nargout}] = diagSolve(transposeFlagA, A, B, aDist, throwMrdivideErrors);
            return
        end
        
        if issparse(A) % Sparse methods
            % If input B is single, throw
            if distributedutil.CodistParser.isa(B,'single')
                if throwMrdivideErrors
                    ME = MException(message('MATLAB:mrdivide:sparseSingleNotSupported'));
                else
                    ME = MException(message('MATLAB:mldivide:sparseSingleNotSupported'));
                end
                throwAsCaller(ME);
            end
            if any(strncmpi(matrixType, {'LowerTriangular', 'UpperTriangular'}, 1))
                [varargout{1:nargout}] = sparseTriangularSolve(transposeFlagA, ...
                    A, B, aDist, matrixType);
            elseif strcmp(matrixType, 'ZeroMatrix')  % Zero case with correct output for sparse
                varargout{1} = B/0;
                if nargout>1
                    varargout{2} = 0;
                end
            else % General matrix
                [varargout{1:nargout}] = cparLuSolve(transposeFlagA, A, B, throwMrdivideErrors);
            end
        else % Dense methods
            isSparseB = issparse(B);
            % If A single and B sparse, throw
            if distributedutil.CodistParser.isa(A,'single') && isSparseB
                if throwMrdivideErrors
                    ME = MException(message('MATLAB:mrdivide:sparseSingleNotSupported'));
                else
                    ME = MException(message('MATLAB:mldivide:sparseSingleNotSupported'));
                end
                throwAsCaller(ME);
            end
            % Try to make B full for use within SCALAPACK
            if isSparseB
                try % Error must be thrown on all workers
                    B = distributedutil.syncOnError(@full, B);
                catch
                    ME = MException(message('parallel:distributed:SparseOutOfMemory'));
                    throwAsCaller(ME);
                end
            end
            % Use the most efficient solver
            if any(strncmpi(matrixType, {'LowerTriangular', 'UpperTriangular'}, 1))
                [varargout{1:nargout}] = pblasTriangularSolve(transposeFlagA, A, B, matrixType);
            elseif  strcmp(matrixType, 'ZeroMatrix') % Zero case with correct output for dense
                [varargout{1:nargout}] = pblasTriangularSolve(transposeFlagA, A, B, 'LowerTriangular');
            else % General matrix
                [varargout{1:nargout}] = scalaLuSolve(transposeFlagA, A, B);
            end
        end
    else  % Not square case
        iErrorForSparseInputs(A, B, throwMrdivideErrors);
        varargout{1} = scalaQrSolve(transposeFlagA, A, B);
    end
else
    bDist = getCodistributor(B);
    if ~( isa(bDist, 'codistributor1d') && (bDist.Dimension == 2) )
        B = redistribute(B, codistributor1d(2));
        bDist = getCodistributor(B);
    end
    % Since A is not codistributed and B is distributed by columns, the
    % labs all have different linear systems to solve.  A new codistributor
    % will be needed if A is not square.  In any case, the results of the
    % divide operation will have the same column distribution as B, and
    % the number of rows will be the number of columns in the input A.
    % Warnings are issued by the core MATLAB function and rCond is not
    % modified.
    
    % The first dimension of the result depends on the size of A and the
    % used transpose flag of A.
    if transposeFlagA==distributedutil.TransposeFlags.NO_TRANSPOSE
        mRhs = sizeA(2);
    else
        mRhs = sizeA(1);
    end
    aDist = codistributor1d(2, bDist.Partition, [mRhs size(B, 2)]);
    localX = iSolveLocalSystem(transposeFlagA, A, getLocalPart(B), throwMrdivideErrors);
    varargout{1} = codistributed.pDoBuildFromLocalPart(localX, aDist); %#ok<DCUNK>
end
end

function iErrorForSparseInputs(A, B, throwMrdivideErrors)
if (issparse(A) || issparse(B))
    if throwMrdivideErrors
        ME = MException(message('parallel:distributed:MrdivideSparseInput'));
    else
        ME = MException(message('parallel:distributed:MldivideSparseInput'));
    end
    throwAsCaller(ME);
end
end

function iErrorForIncompatibleDimension(A, B, transposeFlagA)
if transposeFlagA==distributedutil.TransposeFlags.NO_TRANSPOSE
    dimToCompare = 1;
else
    dimToCompare = 2;
end

if size(A, dimToCompare) ~= size(B, 1)
    ME = MException(message('MATLAB:dimagree'));
    throwAsCaller(ME);
end
end

function X = iSolveLocalSystem(transposeFlagA, A, B, throwMrdivideErrors)
% Solve A*X = B, but throw any MLDIVIDE errors as MRDIVIDE errors if needed
import distributedutil.TransposeFlags
try
    switch transposeFlagA
        case TransposeFlags.NO_TRANSPOSE
            X = A\B;
        case TransposeFlags.TRANSPOSE
            X = A.'\B;
        case TransposeFlags.CONJUGATE_TRANSPOSE
            X = A'\B;
    end
catch ME
    if throwMrdivideErrors
        % This string replacement technique works as long as all the error
        % IDs continue to use the same theme (identical in all respects
        % except for rdivide/ldivide). Otherwise this code should change to
        % a switch statement.
        newMessageID = strrep( ME.identifier, 'ldivide', 'rdivide' );
        error( message( newMessageID ) );
    else
        rethrow(ME);
    end
end
end
