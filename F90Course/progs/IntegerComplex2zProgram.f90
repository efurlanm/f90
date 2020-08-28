    PROGRAM Testo
     USE Integer_Complex_Arithmetic
      IMPLICIT NONE

       PRINT*, "REAL(3,4)"
       PRINT*, REAL(INTCOMPLEX(3,4))
       PRINT*, "INT(3,4)"
       PRINT*, INT(INTCOMPLEX(3,4))
       PRINT*, "AIMAG(3,4)"
       PRINT*, AIMAG(INTCOMPLEX(3,4))
       PRINT*, "CONJG(3,4)"
       PRINT*, CONJG(INTCOMPLEX(3,4))
       PRINT*, "ABS(3,4)"
       PRINT*, ABS(INTCOMPLEX(3,4))

    END PROGRAM Testo
