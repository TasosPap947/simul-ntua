				SAAM II Release Notes 
				     Version 1.1.1
 
 
Welcome to SAAM II, an application specifically designed for modeling, 
simulating, and analyzing data. 

Version 1.1.1 is a maintenance release which corrects a few bugs and adds
some new features. All Version 1.1 files are compatible with this release.
The Version 1.1 Limitations listed below remain applicable.
 
System Requirements: 
==================== 
 
PC-compatible computer with 80386 CPU (or higher), 
Mathematical coprocessor, 
Windows NT or Windows 95, 
8 Mb Memory, 
5 Mb Disk space, 
1.4 Mb Floppy Drive 
 
 
Installation: 
============= 
 
See manual for installation. 

Known problems when installing SAAM II:
---------------------------------------
SAAM II normally installs without problems under Windows 95.  
However, if you see the following error message during installation

	Unable to start DDE communication with Program Manager
	Abort, Retry, Ignore

which typically occurs when you use a shell (user interface) other 
than Explorer, select Ignore (several times if necessary) and the 
installation should complete successfully.

If not, check the file SYSTEM.INI in your Windows folder.  
If necessary, change the line

	shell=<your shell program>	to	shell=Explorer.exe

Turn off your computer and restart Windows 95.

The same problem can occur when you have the Microsoft Powertoys
installed on your PC. In this case, you can also bypass the same message
that pops up during installation by selecting Ignore several times
and the program should still be installed successfully on your system.

If you still cannot install SAAM II, please call for assistance.
 
Changes for Version 1.1.1: 
============================

NOTE THAT THIS VERSION NO LONGER SUPPORTS WINDOWS 3.1.  IF YOU ARE RUNNING 3.1,
DO NOT INSTALL THIS VERSION.

When plotting, the X-Axis variable value is now correctly calculated when defined
by an equation that contains data (e.g. xvar = 10.0 + lin(smpl)).

The contents of each section of the Statistics Window may now be copied to the
clipboard.

A problem which sometimes led to missing objects when using "Duplicate" has been
resolved.

A print problem in the Numerical module has been corrected (caused equations from
previous model file to be printed).

Variable names in tables and lists are now in more logical order (q1, q2,
q10, q11 instead of q1, q10, q11, q2).


Summary of new features in Version 1.1.1:
=================================

The Compute Log Window now lists the names of any parameters which are constrained
by the high or low limits during a Fit.

The last size and location of windows are retained until a new model is loaded.

When using GEN(A B C) data weighting, all three attributes may be specified 
for each entry in a data column (see documentation).

Exogenous inputs are now listed in chronological order.

The Solutions Window can be open at the same time as other output windows.

When the value of a needed variable cannot be calculated during a Solve or Fit,
its name and the experiment time are listed in the Compute Log Window, along with
the value of each of the parameters.

The Fit convergence criteria has been revised (see documentation).

The Compartmental Matrix and its inverse are now available (see documentation).

The Area under Curve for all Samples may be calculated (see documentation).


Changes for Version 1.1: 
======================= 
 
1) The structure of saved study files has changed.  Earlier versions of 
SAAM II will not read Version 1.1 files.  Files created with earlier 
versions are compatible with Version 1.1, but be sure to check the 
Computational Settings as defaults are used for information not included 
in the older files.

2) Version 1.1 will not allow data values of 0.0 when using FSD weighting.  
Version 1.0.2 provided a warning and ignored the data point(s).  If this 
problem is encountered, remove the data points, change the weighting, or 
unweight the points using "(-)".

3) Because the method for measuring integrator accuracy has been modified in 
Version 1.1, some compartmental models may Solve and Fit slower than in previous
versions. Adding an absolute integrator error based on the expected mass in your 
compartments should improve performance considerably (up to an order of magnitude
speed increase). Compartmental models containing delays with large numbers of 
compartments can cause a significant reduction in integrator performance if an
absolute error is not used.


Summary of new features and major changes in Version 1.1:
=================================================

	- Added Bayesian parameter estimation.
	- Added new optimization statistics and parameter confidence intervals.
	- Added accuracy controls for both integrator and optimizer.
	- Revised data weighting.
	- Added additional integrators.
	- Added Compute Log window for more complete error description.
	- Added linear interpolation function.
	- Exogenous inputs can now be repeated at specified intervals.
	- Added equation end-of-line continuation character syntax.
	- Exogenous input variables can now be referenced in other equations.
	- Table window can now be opened directly from main Show menu.
	- Unweighted data points are plotted.
	- Delay mass can now be referenced in equations.
	- Added slider for control of model scale.
	- Can now abort a Solve.
	- Replaced "Defaults" by "Preferences" and "Computational Settings".
	- Objects can now be moved, deleted, etc. while in Experimental mode.
	- Study files are platform-independent between Mac and PC.
	- Both Compwin and Numwin use the same new and improved Help system.


SAAM II 1.1 Limitations: 
========================== 
 
The following limitations exist in the 1.1 release of SAAM II for the PC: 
 
 
Common to both modules 
---------------------- 
1) Under Windows 3.1x, any printer settings that you manually set
in the Print Setup dialog box are ignored when printing the Data,
Equations, Table, Values, Statistics or Notes window.
When you choose Print or Print One Copy from the File menu from any of
these windows, the application always uses the system default printer settings.

2) Under certain conditions, SAAM II cannot solve the steady state 
equations (Compartmental module) or user-supplied simultaneous linear 
equations. This happens when the "condition number" of the associated 
coefficient matrix is greater than 1e+8. The condition number of the 
matrix, which is the ratio of its largest eigenvalue to its smallest 
eigenvalue, is a measure of how "stable" the final solution is.

For example, given the following equations
    a = 0.99999999 * b + 1
    b = 0.99999999 * a - 1

the corresponding matrix is
    [ 1.0         0.99999999]
    [ 0.99999999  1.0       ]

This matrix is real and symmetric. Hence its singular values are 
eigenvalues and satisfy the equation
    (1 - lambda)^2 - (0.99999999)^2 = 0

The corresponding eigenvalues are
    lambda = 1 + 0.99999999 = 1.99999999
    lambda = 1 - 0.99999999 = 1e-8

The condition number is 1.99999999 / 1e-8, which is greater than 1e+8 
hence SAAM II will not solve the equations. 

On the other hand SAAM II will solve the equations
    a = 0.9999 * b + 1
    b = 0.9999 * a - 1

In this example, the condition number is 1.9999e+4

 
Compartmental Module specific 
----------------------------- 
1) When using a system (tracee) experiment, the model must be linear and 
in a steady state. Linear implies that the flow rates do not change as a 
function of time. Steady state implies that the mass of material in 
each compartment is constant with respect to time.  Although this 
version allows system experiments to be created when the model is non-linear
and/or non-steady state, the solution for the system experiment will be
incorrect.  Do not use a system experiment in models where, for example, the 
endogenous input U(1) = 1.0 + t, or where a transfer coefficient varies
with time, as in k(1,2) = 0.01 + t / 100. 
 
2) When data occurs at a break point (change condition or exogenous 
input), the data is assumed to be subsequent to all changes.  If, for 
example, a sample is defined as "s1 = q1" and a change condition occurs 
such that "q1 = 0.0" at time t = 2.0, then SAAM II assumes that the 
change has already occurred for the value of s1 at time t = 2.0.  If you 
wish to assure that the change condition occurs after the measurement 
time, you can either set the measurement time to 1.9999 or the time for 
the change condition to 2.0001. 
 
3) The compartmental module is designed to solve and fit biological problems
which obey conservation of mass. If used for other problems, particularly 
where the solution grows exponentially with time, a relative integrator error
smaller than the default value provided may be necessary to obtain an 
acceptable fit.

Numerical Module specific 
------------------------- 
Variable names longer than 34 characters that are associated with data 
will be truncated to produce names of residuals.  This may result in 
duplicate equations for residuals and incorrect statistics.  
Workaround:  don't use variable names longer than 34 characters. 
 
Thank you for purchasing SAAM II.

