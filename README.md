# My personal notes on Fortran

Fortran, in the latest version, is a modern programming language, including support for object-oriented programming (type extension and inheritance, polymorphism, dynamic type allocation, procedures linked to type), and support for parallel programming (coarray, looping , array assignment, vectorization help, GPU). It can also be used in conjunction with Python (NumPy F2Py) to create modules to be used interactively in a Jupyter Notebook, bringing together the best of these languages and environments. None is better than the other, each has its own application. Fortran is developed by the Working Group 5 of Sub-Committee 22 of the Joint Technical Committee 1 of the International Organization for Standardization and the International Electrotechnical Commission (IEC). This group is known as WG5. [*(Source)*](https://gcc.gnu.org/onlinedocs/gfortran/Fortran-2008-status.html)



## Directories mirrored from ftp://ftp.liv.ac.uk/pub/

* http://github.com/efurlanm/f90/blob/master/F90Course
* http://github.com/efurlanm/f90/blob/master/HPFCourse
* http://github.com/efurlanm/f90/blob/master/HPFFMatter
* http://github.com/efurlanm/f90/blob/master/HTMLHPFCourse

The above directory listing can also be found at

* http://web.archive.org/web/20170706012641/ftp://ftp.liv.ac.uk/pub/F90Course
* http://web.archive.org/web/20170706012641/ftp://ftp.liv.ac.uk/pub/HPFCourse
* http://web.archive.org/web/20170706012641/ftp://ftp.liv.ac.uk/pub/HPFFMatter

("HTMLHPFCourse" is the content of the compressed file HTMLHPFCourse.tar.gz)



## My Notebook notes

* http://github.com/efurlanm/f90/blob/master/MyNotes



## IDRIS

Institut du Développement et des Ressources en Informatique Scientifique

MPI course with many examples in F90

* http://github.com/efurlanm/f90/blob/master/IDRIS

Source: http://www.idris.fr/formations/mpi/



## Intel Fortran

Intel oneAPI Toolkits are available at no cost and do not require license files. Includes _ifort_ Intel Fortran Compiler Classic (Full 77, 90, 95, 2003, 2008, and 2018), and _ifx_ Intel Fortran Compiler Beta (Full 77, 90, 95, and partial 2003). ifx uses the LLVM back-end technology and is released as a Beta version for users interested in trying Intel Gen9 GPU offloading, which ifort does not support

* https://software.intel.com/content/www/us/en/develop/articles/free-intel-software-developer-tools.html

ifort - full implementation of the Fortran 2018 standard

* https://software.intel.com/content/www/us/en/develop/articles/intel-oneapi-fortran-compiler-release-notes.html

Intel releases oneAPI Toolkit, free, Fortran 2018

* https://fortran-lang.discourse.group/t/intel-releases-oneapi-toolkit-free-fortran-2018/471

Intel compiler is free (as in beer) as part of oneAPI

* https://www.reddit.com/r/cpp/comments/kafmsz/intel_c_compiler_is_free_as_in_beer_as_part_of/

Install Using Package Managers

* https://software.intel.com/content/www/us/en/develop/documentation/installation-guide-for-intel-oneapi-toolkits-linux/top/installation/install-using-package-managers.html
* https://software.intel.com/content/www/us/en/develop/articles/installing-intel-oneapi-toolkits-via-yum.html

Intel oneAPI Developer Tools -- Introduction and Install

* https://www.pugetsystems.com/labs/hpc/Intel-oneAPI-Developer-Tools----Introduction-and-Install-2054/

Intel oneAPI AI Analytics Toolkit -- Introduction and Install with conda

* https://www.pugetsystems.com/labs/hpc/Intel-oneAPI-AI-Analytics-Toolkit----Introduction-and-Install-with-conda-2068/

PARF - Parallel Random Forest Algorithm, MPI-enabled, compiled with Intel Fortran 2021.2

* https://github.com/efurlanm/parf



## Fortran 2018

JTC1/SC22/WG5, Fortran 2018, ISO/IEC 1539:2018

* http://wg5-fortran.org/f2018.html
    JTC1/SC22 is the international standardization subcommittee for programming languages, their environments and system software interfaces. WG5 is the Fortran working group (http://wg5-fortran.org/).

Specs

* http://fortranwiki.org/fortran/show/Fortran+2018

Fortran 2018 Examples

* https://github.com/scivision/fortran2018-examples

Fortran 2018 Features supported by GNU Fortran

* https://gcc.gnu.org/wiki/Fortran2018Status

Fortran 2018 Interpretation Document

* https://j3-fortran.org/doc/year/18/18-007r1.pdf

TS 18508 Additional ParallelFeatures in Fortran

* http://isotc.iso.org/livelink/livelink?func=ll&objId=17288706&objAction=Open




## Fortran 2008

Considering that F2018 is a small revision of F2008, then most of the features are the same.

Fortran 2008 Features supported by GNU Fortran

* https://gcc.gnu.org/wiki/Fortran2008Status

Specs

* http://fortranwiki.org/fortran/show/Fortran+2008




## Fortran 202x (Development)

Schedule and documents

* https://wg5-fortran.org/f202x.html

Fortran 202x draft

* https://j3-fortran.org/doc/year/21/21-007.pdf




## NVF2021

NVIDIA CUDA Fortran 2021 compiler and tool chain, former PGI compilers, supports F2003 and many features of F2008, CUDA, SIMD vectorization, OpenACC and OpenMP for multicore x86-64, Arm, and OpenPOWER CPUs

* https://developer.nvidia.com/cuda-fortran
* https://docs.nvidia.com/hpc-sdk/compilers/cuda-fortran-prog-guide



## Fortran Compilers

Listing of open source and commercial compilers

* https://fortran-lang.org/compilers/


## Notes on F2Py

F2PY provide a connection between Python and F90 languages, and allows you to bring together the best of both worlds. It is not a replacement for the F90, it is just a way to take advantage of the rapidly developing features of the Python ecosystem, and in this way without having to reinvent the wheel

* https://numpy.org/doc/stable/f2py/

Perhaps the best way to use it is in conjunction with Jupyter Notebook, as in this example (note the use of both languages): 

* https://gist.github.com/shane5ul/79340646ba0a4487c9da50b805215369



## Books

[![](https://raw.githubusercontent.com/efurlanm/f90/master/img/ray2020.jpg)](https://www.google.com.br/books/edition/Fortran_2018_with_Parallel_Programming/_natDwAAQBAJ)
[![](https://raw.githubusercontent.com/efurlanm/f90/master/img/cohen2018.jpg)](https://www.google.com.br/books/edition/Modern_Fortran_Explained/sB1rDwAAQBAJ)
[![](https://raw.githubusercontent.com/efurlanm/f90/master/img/chapman2017.jpg)](https://www.google.com.br/books/edition/FORTRAN_FOR_SCIENTISTS_ENGINEERS/OQhBMQAACAAJ)

(click on the book to see more details)



## Collection of links of interest

* [BCS Fortran Specialist Group](https://fortran.bcs.org/). Open forum for Fortran users.
* [WG5 ISO IEC Fortran Standards](https://wg5-fortran.org/).
* [US Fortran Programming Language Standards Technical Committee](https://j3-fortran.org/).
* [High Performance Fortran (HPF)](https://www.netlib.org/hpf/index.html). Extensions to F90.
* [Tutorialspoint Learn Fortran](https://www.tutorialspoint.com/fortran/). Tutorial designed for beginners.
* [Tutorialspoint Online Fortran compiler](https://www.tutorialspoint.com/compile_fortran_online.php). Compile and Execute FORTRAN-95 Online (GNU Fortran, GCC).
* [Modern Fortran by Example](https://www.youtube.com/user/hexafoil/videos). Series of video tutorials.
* SHENE, Dr.C.-K. [Fortran 90 Tutorial](https://pages.mtu.edu/~shene/COURSES/cs201/NOTES/fortran.html). Michigan Technological University.
* PAGE, Dr.C. [Clive Page's list of Fortran Resources](https://www.star.le.ac.uk/~cgp/fortran.html). University of Leicester, UK.
* MOZAFFARI, M.R. [Teaching Computational Physics](http://www.alum.sharif.ir/~reza_mozaffari/Teaching_computational_physics.html). University of Qom, Qom-Iran. Fortran Programming for beginner; Useful C++ and Fortran Documentations; C++ and Fortran Libraries.



## Videos of interest

* [The IBM 1401 compiles and runs FORTRAN II [2018]](https://youtu.be/uFQ3sajIdaM). 1959 IBM mainframe computer at the Computer History Museum. 63-pass Fortran compiler that ran in only 8 k of core. Compiles to bytecode which is then executed by an interpreter. The video description includes several links and information.
* [FortranCon2020 [Keynote]: Fortran 2018...and Beyond [2020]](https://youtu.be/mn8QMp6J3R0). Includes an overview of what's new in Fortran 2018.
* [FortranCon2020 [SP]: Parallelization of a Legacy Software through Fortran 2018 Standard [2020]](https://youtu.be/ib4ZZ7xJwJk). Results of a modernization and parallelization of an existing application developed by the Brazilian Electrical Energy Research Center (Cepel).
* [First Experiences with Parallel Application Development in Fortran 2018 [2018]](https://youtu.be/01-ez4v4YPc). Performance results and scalability of algorithms from the National Center for Atmospheric Research (NCAR), using Fortran 2018 and running on platforms with up to 98,000 cores.
