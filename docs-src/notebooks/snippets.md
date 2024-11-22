# Snippets

*Last edited: 2023-12-13*

Some code snippets that I collect over time.

### Arrays


```python
%%writefile test04.f90
program main
    integer :: i, j, k, N=3
    real, dimension(3, 3, 3) :: a
    a = reshape([.50, .73, .22, .29, .65, .41, .69, .25, .76, .64, .60, .73, &
        .93, .24, .63, .19, .73, .77, .93, .70, .29, .53, .34, .20, .91, .02, &
        .47], shape(a),order=[3,2,1])
    write(*,"(*(xg0.2))")(((a(k,j,:)),new_line('A'),j=1,N),new_line('A'),k=1,N)
    write(*,"(*(xg0.2))") a, new_line('A')
end
```

    Overwriting test04.f90



```python
!gfortran -fimplicit-none -s -Wl,-z,norelro test04.f90; ./a.out; wc -c a.out
```

     0.50 0.73 0.22 
     0.29 0.65 0.41 
     0.69 0.25 0.76 
     
     0.64 0.60 0.73 
     0.93 0.24 0.63 
     0.19 0.73 0.77 
     
     0.93 0.70 0.29 
     0.53 0.34 0.20 
     0.91 0.20E-1 0.47 
     
    
     0.50 0.64 0.93 0.29 0.93 0.53 0.69 0.19 0.91 0.73 0.60 0.70 0.65 0.24 0.34 0.25 0.73 0.20E-1 0.22 0.73 0.29 0.41 0.63 0.20 0.76 0.77 0.47 
    
    11400 a.out


### CSV


```python
import numpy as np
x = np.array( [.50, .73, .22, 
               .29, .65, .41, 
               .69, .25, .76] ).reshape(3,3)
np.savetxt("data.csv", x, fmt='%8.4f', delimiter=",")
```


```python
!cat data.csv
```

      0.5000,  0.7300,  0.2200
      0.2900,  0.6500,  0.4100
      0.6900,  0.2500,  0.7600



```python
%%writefile test05.f90
program main
    integer :: i, j, k, N=3
    real, dimension(3,3,3) :: a
    a = reshape([.50, .73, .22,  &
                 .29, .65, .41,  &
                 .69, .25, .76,  &
                 .64, .60, .73,  &
                 .93, .24, .63,  &
                 .19, .73, .77,  &
                 .93, .70, .29,  &
                 .53, .34, .20,  &
                 .91, .02, .47], &
                shape(a),order=[3,2,1])
    do k = 1, N
    do j = 1, N
    write(*,'(*(f5.2:","))') a(k,j,:)
    end do
    write(*,*)
    end do
end
```

    Overwriting test05.f90



```python
!gfortran -fimplicit-none -s -Wl,-z,norelro test05.f90; ./a.out; wc -c a.out
```

     0.50, 0.73, 0.22
     0.29, 0.65, 0.41
     0.69, 0.25, 0.76
    
     0.64, 0.60, 0.73
     0.93, 0.24, 0.63
     0.19, 0.73, 0.77
    
     0.93, 0.70, 0.29
     0.53, 0.34, 0.20
     0.91, 0.02, 0.47
    
    11376 a.out



```python
import numpy as np
x=np.array([1+2j])
np.savetxt("data.csv", x, fmt='%.4f', delimiter=",")
```


```python
!cat data.csv
```

     (1.0000+2.0000j)


### Using fortranmagic


```python
%reload_ext fortranmagic
%fortran_config --defaults
%fortran_config --f90flags "-fimplicit-none"
```



    Deleted custom config. Back to default arguments for %%fortran
    New default arguments for %fortran:
    	--f90flags "-fimplicit-none"



```python
%%fortran
subroutine main(x)
    complex, intent(out) :: x
    x = (16.0650005,2.26032639)
end
```


```python
x = main()
print(type(x), x)
print(main.__doc__)
```

    <class 'complex'> (16.065000534057617+2.260326385498047j)
    x = main()
    
    Wrapper for ``main``.
    
    Returns
    -------
    x : complex
    


### Implicit save attribute
Source: http://www.cs.rpi.edu/~szymansk/OOF90/bugs.html

y is initialized only once


```python
%%fortran
subroutine main(x)
    real, intent(out) :: x
    x = test()  !y is initialized only once
    x = test()  !y is no longer initialized
    x = test()  !y is no longer initialized
contains
    real function test()
        real :: y = 0.0  !y is initialized only once
        y = y + 1
        test = y
    end
end
```


```python
main()
```




    3.0




```python
! gfortran --version
```

    GNU Fortran (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
    Copyright (C) 2021 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    


## 3D Array from Python to Fortran
- https://stackoverflow.com/questions/46318178/reading-arrays-from-npy-files-into-fortran-90


```python
import numpy as np
A = np.random.rand(3, 3, 3)
```


```python
A.T.tofile('data.bin')
```


```python
np.set_printoptions(precision=2)
print(A)
```

    [[[0.36 0.95 0.25]
      [0.73 0.07 0.83]
      [0.4  0.26 0.88]]
    
     [[0.44 0.02 0.17]
      [0.82 0.9  0.59]
      [0.21 0.76 0.8 ]]
    
     [[0.43 0.35 0.37]
      [0.08 0.55 0.75]
      [0.63 0.17 1.  ]]]



```python
%%writefile test06.f90
program main
    integer :: j, k           
    integer, parameter :: N = 3
    real(8), dimension(N, N, N) :: dat
    
    open(0, file='data.bin', access='stream', form='unformatted')
    read(0) dat
    close(0)

    do k = 1, N; do j = 1, N
        write(*,'(*(f4.2:" "))') dat(k,j,:)
    end do; write(*,*); end do
end
```

    Overwriting test06.f90



```python
!gfortran test06.f90 -g -fcheck=all -fimplicit-none
```


```python
!./a.out
```

    0.36 0.95 0.25
    0.73 0.07 0.83
    0.40 0.26 0.88
    
    0.44 0.02 0.17
    0.82 0.90 0.59
    0.21 0.76 0.80
    
    0.43 0.35 0.37
    0.08 0.55 0.75
    0.63 0.17 1.00
    



```python

```
