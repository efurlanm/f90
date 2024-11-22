# implicit none

*Last edited: 2023-12-19*

implicit none (external | type) (Fortran 2018)

## `implicit none (type)`

- Is the same as the existing `IMPLICIT NONE` .

- If an `IMPLICIT NONE` or `IMPLICIT NONE (TYPE)` appears, there must be no other `IMPLICIT` statements in the scoping unit.

- No more than one `IMPLICIT NONE` statement shall appear in a scoping unit.

- `IMPLICIT INTEGER (I-N), REAL (A-H, O-Z)` : represents the default typing as specified by the Fortran Standard for names when they are not explicitly typed.

## `implicit none (external)`

- Means that any references to an external procedure must be to a name that is explicitly declared to have the `EXTERNAL` attribute. In other words, no implicit interfaces.
- If an `IMPLICIT NONE (EXTERNAL)` statement appears in a scoping unit, all dummy procedures and external procedures in that scope or a contained scope of BLOCK must have an accessible explicit interface or be declared `EXTERNAL`.
- As long as they are explicitly declared as procedures, procedures can have an implicit interface.
- External procedure or module must be explicity declared.
- Helps avoid hard-to-detect errors.
- Requires that the names of external and dummy procedures are explicitly declared as having the `external` attribute.
- The declaration can be made by:
    - *external* statement
    - *external* attribute in a type declaration statement
    - *procedure* declaration statement
    - *interface* block


## gfortran -fimplicit-none -Werror=implicit-interface

gfortran has the equivalent flags `-fimplicit-none` and `-Werror=implicit-interface` which allows not to use `implicit none (external | type)` directly in each code written, allowing for simpler and cleaner code. Perhaps the only restriction on the use of flags is when there is a need to use or merge some legacy code.


```python

```


```python
%%writefile a.f90

subroutine a(x)
    integer :: x
    x = 345
end

program main
    ! implicit none (type, external)  ! a() must be explicitly declared

    ! external a     ! or:
    ! procedure() a  ! or:
    ! procedure() :: a

    integer :: x

    call a(x)
    print*, x
end
```

    Overwriting a.f90



```python
! gfortran a.f90 && ./a.out
```

             345



```python
! gfortran -fimplicit-none -Werror=implicit-interface -fno-diagnostics-show-option a.f90 && ./a.out
```

    [01m[Ka.f90:16:13:[m[K
    
       16 |     call a(x)
          |             [01;31m[K1[m[K
    [01;31m[KError:[m[K Procedure ‘[01m[Ka[m[K’ called with an implicit interface at [01;31m[K(1)[m[K
    f951: some warnings being treated as errors



```python
%%writefile a.f90

subroutine F(x)
    real :: x
    x = 123
end

subroutine G(x)
    real :: x
    x = 456
end

real function H(x)
    real :: x
    x = 789
end

program foo
    implicit none (external)
    implicit real(i)  ! this is okay
    external :: G  ! or: 'procedure() G'
    real :: x
    i = 0.0
    call F(i)  ! invalid: F lacks the EXTERNAL attribute.
    call G(i)  ! valid: G has the EXTERNAL attribute.
    x = H(i)   ! function is not affected
end
```

    Overwriting a.f90



```python
! gfortran -Wall -Wextra -std=f2018 a.f90 && ./a.out
```

    [01m[Ka.f90:23:57:[m[K
    
       23 |     call F(i)  ! invalid: F lacks the EXTERNAL attribute.
          |                                                         [01;31m[K1[m[K
    [01;31m[KError:[m[K Procedure ‘[01m[Kf[m[K’ called at [01;31m[K(1)[m[K is not explicitly declared



```python
%%writefile a.f90
program main
    implicit none (type)  ! equal to 'implicit none'
    print*, "Hello, world!"
end
```

    Overwriting a.f90



```python
!gfortran -Wall -Wextra -std=f2018 a.f90 && ./a.out
```

     Hello, world!


## `implicit none` as compiler flag (not 2018 specific)


```python
%%writefile a.f90
program main
    print*, a()
contains
    integer function a()
        a = 123
    end
end
```

    Overwriting a.f90



```python
!gfortran -fimplicit-none -Wall -Wextra -std=f2018 a.f90 && ./a.out
```

             123


## References
- <https://blog.esciencecenter.nl/writing-non-questionable-fortran-part-1-fc5edc7115ee>
- <https://www.intel.com/content/www/us/en/docs/fortran-compiler/developer-guide-reference/2024-0/implicit.html>
- <https://j3-fortran.org/doc/year/13/13-312r4.txt>
- M. Metcalf, J. Reid, and M. Cohen: Modern Fortran Explained <https://www.google.com.br/books/edition/Modern_Fortran_Explained/sB1rDwAAQBAJ>
- <https://fortran-lang.discourse.group/t/what-does-implicit-none-type-external-do/497/>
- <https://community.intel.com/t5/Intel-Fortran-Compiler/implicit-none-type-external-discussion/m-p/1192942>
- <https://www.nersc.gov/assets/Uploads/Whats-new-in-Intel-Fortran-19-1.pdf>
- <https://gcc.gnu.org/wiki/Fortran2018Status>


```python

```
