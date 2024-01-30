function [p,varargout] = colamd (S, varargin)
%COLAMD Column approximate minimum degree permutation.
%    P = COLAMD(S) returns the column approximate minimum degree permutation
%    vector for the sparse matrix S.  For a non-symmetric matrix S, S(:,P)
%    tends to have sparser LU factors than S.  The Cholesky factorization of
%    S(:,P)'*S(:,P) also tends to be sparser than that of S'*S.  The ordering
%    is followed by a column elimination tree post-ordering.
%
%    Usage:  P = colamd (S)
%            [P, stats] = colamd (S, knobs)
%
%    knobs is an optional one- to three-element input vector.  If S is m-by-n,
%    then rows with more than max(16,knobs(1)*sqrt(n)) entries are ignored.
%    Columns with more than max(16,knobs(2)*sqrt(min(m,n))) entries are
%    removed prior to ordering, and ordered last in the output permutation P.
%    Only completely dense rows or columns are removed if knobs(1) and knobs(2)
%    are < 0, respectively.  If knobs(3) is nonzero, stats and knobs are
%    printed.  The default is knobs = [10 10 0].  Note that knobs differs from
%    earlier versions of colamd.
%
%    Type the command "type colamd" for a description of the optional stats
%    output and for the copyright information.
%
%    Authors: S. Larimore and T. Davis, University of Florida.  Developed in
%       collaboration with J. Gilbert and E. Ng.  Version 2.5.
%
%    Acknowledgements: This work was supported by the National Science
%       Foundation, under grants DMS-9504974 and DMS-9803599.
%
%    See also AMD, SYMAMD, COLPERM, SYMRCM.
 
%  Used by permission of the Copyright holder.  This version has been modified
%  by The MathWorks, Inc. and their revision information is below:
%
%  Additional Notice from the original authors is below:
%    Notice:
%
%	Copyright (c) 1998-2006, Timothy A. Davis, All Rights Reserved.
%
%    Availability:
%
%       colamd and symamd are available at
%       http://www.cise.ufl.edu/research/sparse/colamd

%-------------------------------------------------------------------------------
% Perform the colamd ordering:
%-------------------------------------------------------------------------------

[p, varargout{1:nargout-1}] = colamdmex(S, varargin{:});

%-------------------------------------------------------------------------------
% column elimination tree post-ordering:
%-------------------------------------------------------------------------------

[~, q] = etree(S(:,p), 'col');
p = p(q);

%    stats is an optional 20-element output vector that provides data about the
%    ordering and the validity of the input matrix S.  Ordering statistics are
%    in stats (1:3).  stats (1) and stats (2) are the number of dense or empty
%    rows and columns ignored by COLAMD and stats (3) is the number of
%    garbage collections performed on the internal data structure used by
%    COLAMD (roughly of size 2.2*nnz(S) + 4*m + 7*n integers).
%
%    MATLAB built-in functions are intended to generate valid sparse matrices,
%    with no duplicate entries, with ascending row indices of the nonzeros
%    in each column, with a non-negative number of entries in each column (!)
%    and so on.  If a matrix is invalid, then COLAMD may or may not be able
%    to continue.  If there are duplicate entries (a row index appears two or
%    more times in the same column) or if the row indices in a column are out
%    of order, then COLAMD can correct these errors by ignoring the duplicate
%    entries and sorting each column of its internal copy of the matrix S (the
%    input matrix S is not repaired, however).  If a matrix is invalid in other
%    ways then COLAMD cannot continue, an error message is printed, and no
%    output arguments (P or stats) are returned.  COLAMD is thus a simple way
%    to check a sparse matrix to see if it's valid.
%
%    stats (4:7) provide information if COLAMD was able to continue.  The
%    matrix is OK if stats (4) is zero, or 1 if invalid.  stats (5) is the
%    rightmost column index that is unsorted or contains duplicate entries,
%    or zero if no such column exists.  stats (6) is the last seen duplicate
%    or out-of-order row index in the column index given by stats (5), or zero
%    if no such row index exists.  stats (7) is the number of duplicate or
%    out-of-order row indices.
%
%    stats (8:20) is always zero in the current version of COLAMD (reserved
%    for future use).
