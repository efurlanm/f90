    PROGRAM Testo
     USE Integer_Complex_Arithmetic
      IMPLICIT NONE
      TYPE(INTCOMPLEX) :: var1, var2, ans
  
       var1 = 3
       PRINT*, "var1 = 3"
       PRINT*, var1
       PRINT*, ""

       var1 = 6.0
       PRINT*, "var1 = 6.0"
       PRINT*, var1
       PRINT*, ""

       var1 = 6.2
       PRINT*, "var1 = 6.2"
       PRINT*, var1
       PRINT*, ""

       var1 = 6.6
       PRINT*, "var1 = 6.6"
       PRINT*, var1
       PRINT*, ""

       var1 = INTCOMPLEX(1,2)
       var2 = INTCOMPLEX(3,4)

       PRINT*, "(1,2)+(3,4)"
       ans = var1 + var2
       PRINT*, "Answer is ", ans
       PRINT*, ""

       PRINT*, "(1,2)-(3,4)"
       ans = var1 - var2
       PRINT*, "Answer is ", ans
       PRINT*, ""

       PRINT*, "(1,2)/(3,4)"
       ans = var1 / var2
       PRINT*, "Answer is ", ans
       PRINT*, ""

       PRINT*, "(3,4)/(3,4)"
       ans = var2 / var2
       PRINT*, "Answer is ", ans
       PRINT*, ""

       PRINT*, "(3,4)/(1,2)"
       ans = var2 / var1
       PRINT*, "Answer is ", ans
       PRINT*, ""

       PRINT*, "(1,2)*(3,4)"
       ans = var1 * var2
       PRINT*, "Answer is ", ans
       PRINT*, ""

       PRINT*, "(1,2)**3"
       ans = var1 ** 3
       PRINT*, "Answer is ", ans
       PRINT*, ""

       PRINT*, "+(1,2)"
       ans = +var1
       PRINT*, "Answer is ", ans
       PRINT*, ""

       PRINT*, "-(1,2)"
       ans = -var1
       PRINT*, "Answer is ", ans
       PRINT*, ""

       PRINT*, "(1,2)/(3,4)"
       ans = var1 / var2
       PRINT*, "Answer is ", ans
       PRINT*, ""

       PRINT*, "REAL(3,4)"
       PRINT*, REAL(INTCOMPLEX(3,4))
       PRINT*, ""

       PRINT*, "INT(3,4)"
       PRINT*, INT(INTCOMPLEX(3,4))
       PRINT*, ""

       PRINT*, "AIMAG(3,4)"
       PRINT*, AIMAG(INTCOMPLEX(3,4))
       PRINT*, ""

       PRINT*, "CONJG(3,4)"
       PRINT*, CONJG(INTCOMPLEX(3,4))
       PRINT*, ""

       PRINT*, "ABS(3,4)"
       PRINT*, ABS(INTCOMPLEX(3,4))

    END PROGRAM Testo
