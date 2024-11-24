# My personal notes on Fortran and related topics

*Last edited: 2024-11-22*

This repository contains my personal notes on subjects related to Fortran which I find interesting and write down over time. It is a work in progress and subject to constant change.

## Introduction

Fortran is one of the first programming languages and over time it has been improved and updated, and today it can be considered a modern programming language, including support for object-oriented programming (type extension and inheritance, polymorphism, dynamic type allocation, procedures linked to type), and support for parallel programming (coarray, looping , array assignment, vectorization help, etc.). It is a productive, relatively small, high-level language that is easy to learn and use, allowing programmers to focus on the program's algorithm without having to worry about too many technical details. An important feature is that it generally produces fast code, sometimes as fast as C, without the need to resort to low/medium level languages. An interesting detail is that Python/Numpy/[F2PY](https://numpy.org/doc/stable/f2py/) has good integration, allowing you to use Fortran in parts that require performance, and in this way trying to combine the best of both worlds, especially when using Python's interactivity and easy prototyping features. Fortran is used in various areas of science and engineering, such as numerical prediction of climate and oceans, computational fluid dynamics, applied mathematics, statistics and finance, high-performance computing and supercomputers.

## Fortran 2023

* Standard and documents. <https://wg5-fortran.org/f2023.html>
* Fortran 2023 draft. <https://j3-fortran.org/doc/year/21/21-007.pdf>
* Modern FORTRAN Explained 6th ed. <https://www.amazon.com.br/Modern-Fortran-Explained-Incorporating-2023/dp/0198876580>
* Intel compiler including some Fortran 2023 features. <https://www.intel.com/content/www/us/en/developer/articles/release-notes/oneapi-fortran-compiler-release-notes.html>
* Summary of changes [J Reid].: <https://fortran.bcs.org/2022/AGM22_Reid.pdf>
* New features [J Reid]. <https://wg5-fortran.org/N2201-N2250/N2212.pdf>

## Fortran 2018

JTC1/SC22/WG5, Fortran 2018, ISO/IEC 1539:2018

* JTC1/SC22 is the international standardization subcommittee for programming languages, their environments and system software interfaces. <http://wg5-fortran.org/f2018.html>
* Specs. <http://fortranwiki.org/fortran/show/Fortran+2018>
* Fortran 2018 Examples. <https://github.com/scivision/fortran2018-examples>
* Fortran 2018 Features supported by GNU Fortran. <https://gcc.gnu.org/wiki/Fortran2018Status>
* Fortran 2018 Interpretation Document. <https://j3-fortran.org/doc/year/18/18-007r1.pdf>
* TS 18508 Additional ParallelFeatures in Fortran. <http://isotc.iso.org/livelink/livelink?func=ll&objId=17288706&objAction=Open>

## Fortran 2008

Considering that F2018 is a small revision of F2008, then most of the features are the same.

* Fortran 2008 Features supported by GNU Fortran. <https://gcc.gnu.org/wiki/Fortran2008Status>
* Specs. <http://fortranwiki.org/fortran/show/Fortran+2008>

## Intel Fortran

Intel oneAPI Toolkits are available at no cost and do not require license files. Includes *ifort* Intel Fortran Compiler Classic (Full 77, 90, 95, 2003, 2008, and 2018), and *ifx* Intel Fortran Compiler Beta (Full 77, 90, 95, and partial 2003). *ifx* uses the LLVM back-end technology and is released as a Beta version for users interested in trying **Intel Gen9 GPU** offloading, which ifort does not support.

- Intel ifort - full implementation of the Fortran 2018 standard. Free Intel Software Development Tools. <https://software.intel.com/content/www/us/en/develop/articles/free-intel-software-developer-tools.html>
- Intel oneAPI - Intel oneAPI Toolkit, free, Fortran 2018. Intel Fortran Compiler for oneAPI Release Notes. <https://software.intel.com/content/www/us/en/develop/articles/intel-oneapi-fortran-compiler-release-notes.html>
- oneAPI announce on fortran-lang - Intel compiler free as part of oneAPI. Intel releases oneAPI Toolkit, free, Fortran 2018 - Announcements - Fortran Discourse. <https://fortran-lang.discourse.group/t/intel-releases-oneapi-toolkit-free-fortran-2018/471>
- Install Using Package Managers. Install Using Package Managers.  <https://software.intel.com/content/www/us/en/develop/documentation/installation-guide-for-intel-oneapi-toolkits-linux/top/installation/install-using-package-managers.html>
- Intel oneAPI Developer Tools - Introduction and Install. Intel oneAPI Developer Tools -- Introduction and Install. <https://www.pugetsystems.com/labs/hpc/Intel-oneAPI-Developer-Tools----Introduction-and-Install-2054/>
- Intel oneAPI AI Analytics Toolkit - Introduction and Install with conda. Intel oneAPI AI Analytics Toolkit -- Introduction and Install with conda. <https://www.pugetsystems.com/labs/hpc/Intel-oneAPI-AI-Analytics-Toolkit----Introduction-and-Install-with-conda-2068/>

## NVF

NVIDIA CUDA Fortran compiler and tool chain, former PGI compilers, supports F2003 and many features of F2008, CUDA, SIMD vectorization, OpenACC and OpenMP for multicore x86-64, Arm, and OpenPOWER CPUs.

* CUDA Fortran. <https://developer.nvidia.com/cuda-fortran>
* Programming guide. <https://docs.nvidia.com/hpc-sdk/compilers/cuda-fortran-prog-guide>

## F2PY

* F2PY provide a connection between Python and F90 languages, and allows you to bring together the best of both worlds. It is not a replacement for the F90, it is just a way to take advantage of the rapidly developing features of the Python ecosystem, and in this way without having to reinvent the wheel. <https://numpy.org/doc/stable/f2py/>
* Perhaps the best way to use it is in conjunction with Jupyter Notebook, as in this example (note the use of both languages): <https://gist.github.com/shane5ul/79340646ba0a4487c9da50b805215369>

## Random notes

Some interesting things I collect over time.

* Fortran 2018 `implicit none (external | type)` : [notebooks/implicit.md](notebooks/implicit.md)

* My version of PARF Parallel Random Forest Algorithm, MPI-enabled, compiled with Intel Fortran 2021.2. <https://github.com/efurlanm/ml>

## Assembly

For debugging and optimization purposes it is important to know the "assembly" language generated by a compiler. I make some [assembly notes in a separate documentation](https://efurlanm.github.io/ldi/assembly/).

## Links of interest

* Listing of open source and commercial compilers. <https://fortran-lang.org/compilers/>
* BCS Fortran Specialist Group. Open forum for Fortran users. <https://fortran.bcs.org/>
* WG5 ISO IEC Fortran Standards. <https://wg5-fortran.org/>
* US Fortran Programming Language Standards Technical Committee. <https://j3-fortran.org/>
* High Performance Fortran (HPF). Extensions to F90. <https://www.netlib.org/hpf/index.html>
* Tutorialspoint Learn Fortran. Tutorial designed for beginners. https://www.tutorialspoint.com/fortran/)
* Tutorialspoint Online Fortran compiler. Compile and Execute FORTRAN-95 Online (GNU Fortran, GCC).<https://www.tutorialspoint.com/compile_fortran_online.php>
* SHENE, Dr.C.-K. Michigan Technological University. Fortran 90 Tutorial. <https://pages.mtu.edu/~shene/COURSES/cs201/NOTES/fortran.html>
* PAGE, Dr.C. University of Leicester, UK. Clive Page's list of Fortran Resources. <https://www.star.le.ac.uk/~cgp/fortran.html>

## Videos of interest

* [The IBM 1401 compiles and runs FORTRAN II](https://youtu.be/uFQ3sajIdaM). 1959 IBM mainframe computer at the Computer History Museum. 63-pass Fortran compiler that ran in only 8 k of core. Compiles to bytecode which is then executed by an interpreter. The video description includes several links and information.
* [FortranCon2020 [Keynote]: Fortran 2018...and Beyond](https://youtu.be/mn8QMp6J3R0). Includes an overview of what's new in Fortran 2018.
* [FortranCon2020 [SP]: Parallelization of a Legacy Software through Fortran 2018 Standard](https://youtu.be/ib4ZZ7xJwJk). Results of a modernization and parallelization of an existing application developed by the Brazilian Electrical Energy Research Center (Cepel).
* [First Experiences with Parallel Application Development in Fortran 2018](https://youtu.be/01-ez4v4YPc). Performance results and scalability of algorithms from the National Center for Atmospheric Research (NCAR), using Fortran 2018 and running on platforms with up to 98,000 cores.
* [Modern Fortran by Example](https://www.youtube.com/user/hexafoil/videos). Series of video tutorials.

## Selected books

[![](img/ray2020.jpg)](https://www.google.com.br/books/edition/Fortran_2018_with_Parallel_Programming/_natDwAAQBAJ) [![](img/cohen2018.jpg)](https://www.google.com.br/books/edition/Modern_Fortran_Explained/sB1rDwAAQBAJ) [![](img/chapman2017.jpg)](https://www.google.com.br/books/edition/FORTRAN_FOR_SCIENTISTS_ENGINEERS/OQhBMQAACAAJ)

(click on the book picture to see more details)
