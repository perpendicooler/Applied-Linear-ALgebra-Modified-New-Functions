# Tensor Toolbox for MATLAB, Version 3.6
September 28, 2023 (last release)         
by Brett W. Bader, Tamara G. Kolda, Daniel M. Dunlavy, et al.        
Sandia National Laboratories and MathSci.ai   

The **Tensor Toolbox for MATLAB** is open source software; see [LICENSE.txt](LICENSE.txt) for the terms of the license (2-clause BSD). 

For a list of contributors, see [CONTRIBUTORS.md](CONTRIBUTORS.md).
For instructions on contributing, see [CONTRIBUTION_GUIDE.md](CONTRIBUTION_GUIDE.md).

For all other information, including download and usage instructions, see [www.tensortoolbox.org](https://www.tensortoolbox.org/).

Release notes follow below.

## Changes in Version 3.6 from Version 3.5 (25-Feb-2023)

- New functions within [`tensor`](@tensor/) class: [`unfold`](@tensor/unfold.m) and [`vec`](@tensor/vec.m) (#78)
- New top-level function [`cp_orth_als`](cp_orth_als.m) for Orthogonalized ALS (!86)
  * Reference: Sharan, V., & Valiant, G. (2017, July). 
    Orthogonalized ALS: A theoretically principled tensor decomposition algorithm for practical use. 
    In International Conference on Machine Learning (pp. 3095-3104). PMLR.
- Improves [`tensor/ttm.m`](@tensor/ttm.m) to use `pagemtimes` rather than explicit looping and permuations. This is the new default. (!88)
- Added pagemtimes option to [`tensor/mttkrp.m`](@tensor/mttkrp.m), but dd not change the default.
- Updated [`ktensor/tovec.m`](@ktensor/tovec.m) to print an error if not including lambda but some lambda entries are not equal to one.
- Updated documentation for [`tensor/subsref.m`](@tensor/subsref.m) and [`sptensor/subsref.m`](@sptensor/subsref.m) to better explain the 1-way tensor behavior (#73)
- Updated documentation for [`tt_sample_semistrat.m`](tt_sample_semistrat.m) (#75)
- Fixed error message in [`gcp_opt`](gcp_opt.m) when stratified sample is used with a dense tensor (#76)
- Fixed check on number of input arguments in [`tt_sample_zeros.m`](tt_sample_zero.m) (#77)
  
## Changes in Version 3.5 from Version 3.4 (21-Sep-2022)

- Added new functionality for alternating randomized least squares via leverage scores per the paper. B. W. Larsen, T. G. Kolda. Practical Leverage-Based Sampling for Low-Rank Tensor Decomposition, SIMAX, 2022 (see !72).
  * New top-level function [`cp_arls_lev`](cp_arls_lev.m) 
  * New functions within [`sptensor`](@sptensor/) class: [`fibers`](@sptensor/fibers.m), [`findices`](@sptensor/findices.m), [`rrf`](@sptensor/rrf.m) 
  * New functions within [`tensor`](@tensor/) class: [`fibers`](@tensor/fibers.m) 
  * New top-level *hidden* functions that aid in randomized least squares: [`tt_fsampler_setup`](tt_fsampler_setup.m), [`tt_leverage_scores`](tt_leverage_scores.m), [`tt_random_sample`](tt_random_sample.m), [`tt_sampled_solve`](tt_sampled_solve.m)    
  * New help page: [Alternating randomized least squares with leverage scores for CP Decomposition](https://www.tensortoolbox.org/cp_arls_lev_doc.html)
- Add new [`sptensor/squash`](@sptensor/squash.m) command to remove empty hyperslices in a sparse tensor. See merge request !83.
- Added additional options to [`ktensor/viz`](@ktensor/viz.m) command (see !82).
- Updated [`LICENSE`](`LICENSE`) so it is recognized automatically by GITLAB.

## Changes in Version 3.4 from Version 3.3 (August 16, 2022)

- Updated `tt_gcp_fg_setup` to fix Negative Binomial loss function. Also added `tests/Test_GCP_OPT.m`. See merge request !78, #65.
- Updated `tt_sample_zeros` to use efficient `ismembc`. See merge request !77, #64.
- Fixed off-by-2 bug in gradient computed by `@ktensor/fg.m`.
- Described `scale` option in `cp_opt`.
- Minor spelling corrections in documentation.

## Changes in Version 3.3 from Version 3.2.1 (April 5, 2021)

### New or substantially changes functionality

- Added new ttensor/reconstruction function to reconstruct a partial and/or downsampled tensor from a ttensor. See merge request !73.
  * New function [`ttensor/reconstruct.m`](@ttensor/reconstruct.m) 
  * New help page: [Partial Reconstruction of a Tucker Tensor](https://www.tensortoolbox.org/ttensor_reconstruct_doc.html)

- Added new functionality for symmetric CP tensor computation using the Subspace Power Method (SPM). See merge request !70.
  * Relevant paper: J. Kileel, J. M. Pereira. "Subspace power method for symmetric tensor decomposition and generalized PCA." arXiv:1912.04007 (2019).
  * New top-level function [`cp_ispm`](cp_ispm.m) 
  * New help page: [Subspace Power Method for Symmetric CP Decomposition](https://www.tensortoolbox.org/cp_spm_doc.html)  

- Added tensor-times-same-vector [`ttsv`](@symktensor/ttsv.m) for `symktensor`. See merge request !69, #61.

### Improved functionality

- Updates to optimization-based methods to continue builing on the common set of wrappers. See !71,!66, #63, #62, #58.
  * Incorportation of LBFGSB by Stephen Becker from [L-BFGS-B-C on GitHub](https://github.com/stephenbeckr/L-BFGS-B-C) directly into this repository as `library/lbfgsb', saving users the trouble of installation.
  * Updated optimization wrappers and the additional of a new wrapper for the MATLAB Optimization Toolbox `fmincon` called [`tt_opt_fmincon`](tt_opt_fmincon.m).
  * New `ktensor/fg.m` - Function and gradient calculation for F(M) = ||M-X||^2/||X||^2 where M is the ktensor (with unit weights) and the gradient is in terms of the factor matrices.
  * New version of (`cp_opt`)[cp_opt.m] that uses the optimization wrappers. The old version is now called (`cp_opt_legacy`)[`cp_opt_legacy.m`]. 

- New and improved version of [`sptensor/mttkrp.m`](@sptensor/mttkrp.m), now 2-3X faster on sparse tensors with O(100k) nonzeros or more. See merge request !74.

- Added ability to do shifting via the tensor [`scale`](@tensor/scale.m) function. Also changed this function to use `bsxfun` which should be generally more efficient. See merge request !62.

- Changed [`indices`](@symtensor/indices.m) to improve performance. See merge request !64,!63,#54.

- Changed [`cp_arls`](cp_arls.m) to default to 5 iterations per epoch rather than 50. See merge request !67,#53.

- Changed [`cp_wopt`](cp_wopt.m) to be able to properly zero out NaN's in data tensor. Prior version didn't work even when weight tensor had zeros for the missing data entries because 0 * NaN = NaN. See merge request !61.


### Minor changes

- Updated help email address in [`doc/html/index.html`](doc/html/index.html) to `help@tensortoolbox.org`. #60

- Updated instructions in [`CONTRIBUTION_GUIDE.md`](CONTRIBUTION_GUIDE.md) to point to `dev` branch rather than `master`, more details on granting permissions, etc.

- Updated help on `ktensor` to construct a ktensor for a vectorized ktensor. #59

- Made sure all the doc pages set the random seed before running so the pages can be easily reproduced, being able to understand which changes are due to changes in algorithms.

- Added option for viz to show the actual weight (rather than the relative weight) and updated documentation.


## Changes from Version 3.2 (February 10, 2021)

- Changes to [`export_data`](export_data.m): support formatting of data and lambda values, improved write times for ['sptensor'](@sptensor/) when exporting (fixes #51)
- New help page: [Importing and Exporting Tensor Data](https://www.tensortoolbox.com/import_export_doc.html)

## Changes from Version 3.1 (June 4, 2019)

- Added new functionality for implicit symmetric CP tensor computation per the paper: S. Sherman, T. G. Kolda. Estimating Higher-Order Moments Using Symmetric Tensor Decomposition, SIMAX, 2020 (see !43)
  * New top-level function [`cp_isym`](cp_isym.m) 
  * New functions within [`symktensor`](@symktensor/) class: [`f_implicit`](@symktensor/f_implicit.m), [`fg_explicit`](@symktensor/fg_explicit.m), [`fg_implicit`](@symktensor/fg_implicit.m), [`g_implicit`](@symktensor/g_implicit.m), [`randextract`](@symktensor/randextract.m), [`update`](@symkensor/update.m)
  * New help page: [Implicit Symmetric CP Decomposition for Symmetric K-Tensors](https://www.tensortoolbox.org/cp_isym_doc.html)
- Added interfaces to various optimization methods, including our own implementation of ADAM (see also !43)
  * New top-level *hidden* functions that serve as somewhat standardized wrappers to optimization methods: [`tt_opt_adam`](tt_opt_adam.m), [`tt_opt_fminunc`](tt_opt_fminunc.m), [`tt_opt_lbfgs`](tt_opt_lbfgs.m), [`tt_opt_lbfgsb.m`](tt_opt_lbfgsb.m)
  * New help pages: [Optimization Methods for Tensor Toolbox](https://www.tensortoolbox.com/opt_options_doc.html) and [Developer Information for Optimization Methods in Tensor Toolbox](https://www.tensortoolbox.com/tt_opt_doc.html)
- Other new help pages: 
  * [Shifted Power Method for Generalized Tensor Eigenproblem](https://www.tensortoolbox.com/eig_geap_doc.html) documenting [`eig_geap`](eig_geap.m) (fixes #11, see !54)
  * [Symmetric CP Decomposition for Symmetric Tensors](https://www.tensortoolbox.com/cp_sym_doc.html) documenting [`cp_sym`](cp_sym.m) (see !43)
- Overhaul of documentation (see !53), including [new logo](doc/html/Tensor-Toolbox-for-MATLAB-Banner.png) (see !55, fixes #18)
  * Plus updated [Contribution Guide](CONTRIBUTION_GUIDE.md) with better instructions (see !44)
  * Added funding and other acknowledgments to [`CONTRIBUTORS.md`](CONTRIBUTORS.md)
  * Removed `RELEASE_NOTES.txt`, putting release notes into `README.md` (this file) in markdown format 
  * Removed `INSTALL.txt`, which was out of date
  * Added [Release Instructions](maintenance/RELEASE_INSTRUCTIONS.md) and [Documentation Instructions](maintenance/DOCUMENTATION_INSTRUCTIONS.md) 
  * Added functions to update toolbox link in `maintenance`
  * Removed `doc/html/bibtex.html`, `doc/html/getting_started.html`, `doc/html/helpscreen.PNG`
- Various bug fixes and minor enhancements
  * Fixed bug in [`@ktensor/score.m`](@ktensor/score.m) to handle zero lambda-values in both inputs (fixes #37)
  * Added [`sptenmat` constructor](@sptenmat/sptenmat.m) check on valid input (fixes #33)
  * Fixed wrong default lower bound in [`gcp_opt`](gcp_opt.m)
  * Specified in [`tucker_sym`](tucker_sym.m) that input must be a `tensor` rather than a `symtensor`, which is admittedly counterintuitive (fixes #44)
  * Fix [`sparse/ttt`](@sptensor/ttt.m) and [`sparse/ttm`](@sptensor/ttm.m) for complex tensors (fixes #40)
  * Fix [`ktensor/full`](@ktensor/full.m) for complex tensors
  * Updated documentation links so that every file now links to www.tensortoolbox.org (fixes #14, see !57) 
  * Added support to export a `ktensor` in [`export_data.m`](export_data.m) plus relevant tests (fixes #23)
  * Updated [`symktensor/normalize`](@symktensor/normalize.m) to be faster by using `bsxfun`
  * Added/updated paper links: [`tensor`](@tensor/tensor.m), [`sptensor`](@sptensor/sptensor.m), [`cp_arls`](cp_arls.m), [`cp_sym`](cp_sym.m)
 
## Changes from Version 2.6 (February 6, 2015)

- Changed license conditions: now open source BSD license.
- New KTENSOR/VIZ function for visualizing the factors produced by the
  CP decomposition.
- Added new CP_SYM and TUCKER_SYM functions for symmetric tensor
  decompositions. Added new SYMTENSOR and SYMKTENSOR classes with
  limited functionality to support symmetric tensors.
- Added new SUMTENSOR class that works with an implicit sum of tensors
  without actually forming the result.
- Added new CP-ARLS method that does alternating *RANDOMIZED* least
  squares fitting for the CP decomposition per Battaglino et al.
- New GCP_OPT method for generalized CP.
- New CREATE_PROBLEM_BINARY method for generating problems where the
  low-rank model corresponds to the odds of a 1.
- Improve KTENSOR/FULL function.
- Added SPTENSOR/SPONES function that replaces nonzero sparse tensor
  elements with ones.
- Removed memory-efficient Tucker (met) code.
- Fixed formatting of lambda in ktensor/disp.
- Fixed type of subs in import_data for sptensor data.
- Made call to fixsigns in cp_als optional.

## Changes from Version 2.5 (February 1, 2012)

Top Level

- Added new EIG_GEAP function for computing generalized tensor
  eigenpairs. Renamed SSHOPM to EIG_SSHOPM and added support for
  adaptive shift (now the default).  Renamed SSHOPMC to EIG_SSHOPMC.
- Major updates to CP_APR, including changing the default to use
  2nd-order optimization per paper of Hansen, Plantenga, & Kolda. See
  method help for more information. 
- Minor changes to CP_ALS: (1) Fixed bug in normalization step. (2)
  Updated some calculations per work of Phan Anh Huy. (3) Forced
  printing of last iteration so long as printitn > 0.
- Updated MTTKRP and KHATRIRAO, per work of Phan Anh Huy.
- Fixed bug in CREATE_PROBLEM for 'Sparse_Generation'.
- Added SPTENSOR support EXPORT_DATA and IMPORT_DATA. Added KTENSOR
  support to IMPORT_DATA.
- Updated random number generator references to the new MATLAB
  implementsion in CREATE_PROBLEM and CREATE_GUESS.
- Added instructions for adding MET to the pat in INSTALL.txt.
- Fixed function name for TT_FAC_TO_VEC per Evrim Acar bug report.
- Added new function MATRANDNORM.
- Renamed TT_CCONG to MATRANDCONG, TT_RANDORTHMATH to MATRANDORTH.
- Removed TT_ASSIGNMENT_TYPE, TT_COMBINATOR, TT_CP_W*,
  TT_CREATE_MISSING_DATA_PATTERN. 
- Modernized documentation with class support.

Class: ktensor

- Fixed SUBSREF to properly handle lists of indices.
- Only call ARRANGE from NORMALIZE if there are multiple
  components. Force ARRANGE to produce dense matrices. Fixes bug
  reported by Jason Mattax on 3/1/2012.
- Fixed comments for NORMALIZE, SUBSREF.
- Added ISSYMMETRIC and SYMMETRIZE functions.
- Constructor can now take SYMKTENSOR as an input.

Class: sptensor

- Fixed bug in SUBSASGN discovered by Sebastien Bratieres pertaining
  to empty tensors.

Class: tensor

- Fixed bug in ISSYMMETRIC with respect to groups.

Acknowledgments:

- The function @symtensor/private/multinomial.m is from Mukhtar Ullah
  and was distributed via the MATLAB file exchange.

## Changes from Version 2.4 (March 22, 2010)

Top Level

- The "algorithms" directory has been eliminated. All routines are now
  at the root level, meaning that only one directory has to be added
  to the path to get all of Tensor Toolbox's standard functionality. 
- Added new CREATE_PROBLEM and CREATE_GUESS routines that can be used
  to generate test problems and initial guesses. These were first used
  at the AIM 2010 Tensor Decomposition workshop. Added TT_RANDORTHMAT,
  a helper function for creating problems.
- Added new SSHOPM and SSHOPMC code for Shifted Symmetric Higher-Order
  Power Method for computing tensor eigenpairs.
- Added new CP_APR method for Poisson Tensor Factorization via
  alternating Poisson regression, along with helper function
  tt_loglikelihood. 
- Added TENEYE to create "identity tensor".
- Helper functions for CP_OPT and CP_WOPT (like cp_fg) now have "tt_"
  prepended to their names. They are not listed in the contents files.
- Adding ability to import and export text versions of matrices and
  tensors via IMPORT_DATA/EXPORT_DATA functions.
- Making calling sequence to TENZEROS, TENRAND, and TENONES
  consistent. Now all three will take either a size array or a list,
  i.e., tenones([5 4 3]) or tenones(5,4,3) produce the same
  results. Eliminated two-argument version of tenzeros, i.e., a call
  to tenzeros(M,N) should be changed to tenzeros(N*ones(1,M)).
- Added additional comments in CP_ALS.
- Made output of CP_WOPT consistent with CP_OPT, i.e., now includes
  output of optimization method.  
- Fixed bug for empty tensor in TENONES.
- Fixed TT_IND2SUB, TT_SUB2IND to handle empty inputs.

Documentation

- Added documentation in the help browser for cp_opt, cp_wopt, cp_als,
  and sshopm.

Class: tensor

- Added SYMMETRIZE function to symmetrize a tensor and ISSYMMETRIC
  function to check if a tensor is symmetric.
- Adding new TTSV function to compute a tensor times the same vector
  in every mode. Intended for symmetric tensors and doesn't allow user
  to specify exactly which modes are skipped.
- Fixed "empty tensor" bugs in TENSOR (constructor), PERMUTE, COLLAPSE.
- Fixed "1D tensor" bug in TENMAT.
- Fixed bug with no results in FIND.
- More error checking in MTTKRP.

CLASS: sptensor

- Added DIVIDE function for elementwise division.

Class: ktensor

- Added new SCORE function to compute "factor match score" for
  two ktensor's. Includes "greedy" option when
- Added new REDISTRIBUTE function to redistribute the weights from
  lambda into a specified mode.
- Fixed bug in NORM, which sometimes returned a negative value due to
  small errors in the calculation. Now it returns max(0,val).
- Added ISEQUAL function that checks for elementwise equality on
  individual components.
- Lots of new options for the NORMALIZE function.

Class: ttensor

- Added ISEQUAL function that checks for elementwise equality on
  individual components.

## Changes from Version 2.3 (July 8, 2009)

General

- tenzeros(m,n): Now has the ability to create an mth-order tensor of
  size n in every mode. tenzeros(siz) still works as usual.
- tt_subcheck now uses isfinite rather than ~isnan and ~isinf based on
  error report from user.

Algorithms

- Added new cp_opt and cp_wopt functions (and related utility
  functions) for computing CP and weighted CP via optimization.
  Requires that the user also install the Poblano Toolbox for
  Matlab. This is freely available at
  http://software.sandia.gov/trac/poblano.
- Changed the way that cp_als and tucker_als handle input arguments so
  that they can now be parameter-value pairs. Should be backwards
  compatible with old calling sequence.
- cp_als: Reverted the way that Unew is calculated from Unew = Unew *
  pinv(Y) to Unew (Y \ Unew')'; which is from TTB2.2 and seems to give
  better performance.

Class: sptensor

- permute - Added check for empty tensor based on user error report.
- spmatrix - Added check for empty tensor based on user error report.
- sptensor - Replaced "~" with "junk" so it will work with Matlab 7.8
  (older version). Allowed sptensor to take an sptensor3 object
  (though this class is not released yet) as input and convert it.

Class: ktensor

- Revamped "arrange" so that it can also just accept a permutation and
  rearrange the components. 
- Adding a new "extract" function to select and extract a subset of the
  components (rank-one factors) of a ktensor. 
- Adding a new function "ncomponents" to return the number of
  components.
- Added a "normalize" function that normalizes the columns of the factor
  matrices to length 1 and absorbs the weights into lambda (without
  rearranging the factors). 
- Added new function "tocell" to convert a ktensor to a cell array.

Class: sptenmat

- In function "double", added check for empty tensor based on error
  report from user.

## Changes from Version 2.2 (January 10, 2007)

General:

- Added Memory Efficient Tucker (MET) package by Tamara Kolda and
  Jimeng Sun. Type 'help tucker_me' after installation for more
  information. 
- Fixed bug in tenzeros command so that it now returns an empty tensor
  when the initial size is emtpy.
- Fixed bug in tt_assignment_type so that it works with a sparse
  tensor that is initially completely empty.
- Added comments to tt_sub2ind and tt_ind2sub.
- Removed errant ^M's at the end of every line of tt_subscheck.

Algorithms:

- Changed parafac_als to cp_als (old one can still be called but is
  deprecated). 
- Added an option to cp_als to only print the information every n
  iterations where n is a user-defined parameter. Also fixed bug in
  the case of R=1.
- Added new cp_nmu function for computing a nonnegative tensor
  factorization based upon Lee & Seung's NMF multiplicative update.
- Made calculation of residual in Tucker more efficient.

Class: tensor

- Adds reshape command.
- Fixed find function so that it always returns a column vector. 
  (Bug# 3969) 
- Fixed tenfun documentation. (Bug# 3339)

Class: sptensor

- Adds reshape and spmatrix commands.
- Fixed bug in constructor so that it checks for subscripts out of
  range and other input problems. (Bug# 3925)
- Fixed bug is subsasgn so that it works for a certain way of
  inserting complex values. (Bug #3868)
- Fixed bug in disp function for sptensor that caused it not to accept
  the user input to display all nonzeros for large tensors. (Bug #4009)
- Fixed bug in collapse so that it handles empty sptensor's correctly.
- Fixed bug in rdivide so that it will work correctly when either
  argument is an empty tensor.
- Fixed bug in squeeze so that it now works correctly for sptensor's
  with no nonzero elements. (Bug #3002)
- Fixed bug in subsasgn for a sptensor so that it works even when the
  initial tensor is completely empty. 
- Fixed bug in ttt so that it works even when one of the sptensors has
  zero nonzeros. (Bug #3017)
- Fixed bug in elemfun that didn't remove those nonzeros that had
  become zero (e.g., log 1 = 0). (Bug# 3235)

Class: sptenmat

- Fixed bug in sptenmat so that it works when it is passed an sptensor
  that doesn't have any entries.

## Changes from Version 2.1 (December 1, 2006)

General:

- Added INSTALL.txt with installation instructions.
- Updated copyright date from 2006 to 2007 throughout.

Classes: tensor and sptensor

- Added transpose and ctranspose functions that throw an error
  (transpose is not supported for tensors, but previously would do
  nothing as if it *had* performed the transpose).
- Added ldivide, rdivide, lmdivide, and rmdivide, though they all work
  only with scalars.

Class: tensor

- Added isequal.
- Made find slightly more efficient in the case where the
  corresponding values are not also returned.
- Fixed bug in assigning elements to 1-dimensional tensors.

Class: sptensor

- Cleaner display with disp or display functions.
- Added checks against invalid sizes and subscripts for tensor
  construction and subscripted reference and assignment.
- Fixed bug where the index 58 was confused with the character ':'
  in subscripted reference and assignment.
- Made results of logical operators consistent with how sparse
  matrices work, i.e., produces a dense tensor iff the equivalent
  command on a sparse matrix would do the same.
- Plus and minus now work with a scalar or dense tensor, and the
  result in those cases is dense.
- Added ability to do .* with a scalar.
- Made it so that isequal now works with dense tensors and will return
  true if the two tensors are equivalent.
- Fixed bugs in double and squeeze on an all-zero sparse tensor.

## Changes from Version 2.0 (September 6, 2006)

All

- innerprod: Added checks that sizes match
- Improved subscripted assignment for tensor and sptensor. Now
  supports assignment to a scalar (i.e., assign every element to that
  scalar) and growth in both the size and number of dimensions.

Class: tensor

- Added new function: nnz
- tenfun (and most relational operations): Fixed major bug is
  dense-sparse comparisons.

Class: sptensor 

- Added new functions: not, and, or, xor, eq, ne, le, lt, ge, gt, isequal
- sptensor: Fixed bug where a 1D tensor was not correctly converted to
  a sparse tensor. Also, added ability to accept an MDA as an input
  and to accept a list of logical values as well as numerics.
- subsref: Fixed bug on subscripted reference to an empty tensor.
- ttt: Major overhaul that fixes a number of bugs and improves
  efficiency dramatically.
- nvecs: Improved efficiency by converting to MATLAB sparse matrix
  and calling eigs on that rather than calling eigs with the aatx
  function. 
- disp/display: Fixed bug that caused tensors with a *single* element
  to display incorrectly.
- full: Fixed bug that caused it to fail if called on a completely
  empty tensor.

Class: ttensor

- innerprod/norm/nvecs: Improved efficiency.
- ttm: Removed errant debug print statements.

Class: ktensor

- datadisp.m: Minor changes to formatting.

Other

- License.txt: Removed an errant "7.3" that was in the text. 
- Fixed top-level contents file and added version information so that
  it will show up from MATLAB's ver command.

## Changes from Version 1.0 (April 13, 2006)

Classes

- Added support for sparse tensors (sptensor and sptenmat)
- Renamed tensor_as_matrix to tenmat
- Renamed tucker_tensor to ttensor
- Renamed cp_tensor to ktensor
- Many functions have substantially improved efficiency

Changes to the tensor class

- Removed functions: issamesize, order, shiftdim
- Renamed functions: multiarrayop to tenfun
- New functions: collapse, contract, find, full, innerprod, mttkrp, nvecs,
  scale

Changes to the ktensor class (formerly cp_tensor)

- Removed functions: issamesize, order
- New functions: datadisp, double, end, fixsigns, innerprod, mttkrp,
  nvecs, times, ttm 

Changes to the ttensor class (formerly tucker_tensor)

- Removed functions: issamesize, order
- New functions: double, end, innerprod, mttkrp, norm, nvecs, ttm, ttv  

Changes to the tenmat class (formerly tensor_as_matrix)

- New functions: end, minus, norm, plus, uminus, uplus

Changes to examples, algorithms, and documentation

- The examples directory no longer exists.
- Instead, documentation has been incorporated directly into the
  MATLAB help navigator.
- Also, a new algorithms directory has been added with two ALS methods
  for CANDECOMP/PARAFAC and Tucker.


