    PROGRAM Testo
     USE Integer_Complex_Arithmetic
     IMPLICIT NONE
     TYPE(INTCOMPLEX) :: var1, var2, ans

     var1 = 3
     PRINT*, "var1 = 3"
     CALL Put_INTCOMPLEX(var1)
     PRINT*, ""

     var1 = 6.0
     PRINT*, "var1 = 6.0"
     CALL Put_INTCOMPLEX(var1)
     PRINT*, ""

     var1 = 6.2
     PRINT*, "var1 = 6.2"
     CALL Put_INTCOMPLEX(var1)
     PRINT*, ""

     var1 = 6.6
     PRINT*, "var1 = 6.6"
     CALL Put_INTCOMPLEX(var1)
     PRINT*, ""

     var1 = Setup_INTCOMPLEX(1,2)
     var2 = Setup_INTCOMPLEX(3,4)

     PRINT*, "(1,2)+(3,4)"
     ans = var1 + var2
     CALL Put_INTCOMPLEX(ans)
     PRINT*, ""

     PRINT*, "(1,2)-(3,4)"
     ans = var1 - var2
     CALL Put_INTCOMPLEX(ans)
     PRINT*, ""

     PRINT*, "(1,2)/(3,4)"
     ans = var1 / var2
     CALL Put_INTCOMPLEX(ans)
     PRINT*, ""

     PRINT*, "(3,4)/(3,4)"
     ans = var2 / var2
     CALL Put_INTCOMPLEX(ans)
     PRINT*, ""

     PRINT*, "(3,4)/(1,2)"
     ans = var2 / var1
     CALL Put_INTCOMPLEX(ans)
     PRINT*, ""

     PRINT*, "(1,2)*(3,4)"
     ans = var1 * var2
     CALL Put_INTCOMPLEX(ans)
     PRINT*, ""

     PRINT*, "(1,2)**3"
     ans = var1 ** 3
     CALL Put_INTCOMPLEX(ans)
     PRINT*, ""

     PRINT*, "+(1,2)"
     ans = +var1
     CALL Put_INTCOMPLEX(ans)
     PRINT*, ""

     PRINT*, "-(1,2)"
     ans = -var1
     CALL Put_INTCOMPLEX(ans)
     PRINT*, ""

     PRINT*, "Type in the two INTCOMPLEX components"
     CALL Get_INTCOMPLEX(var1)
     PRINT*, ""
     PRINT*, "This is what was typed in"
     CALL Put_INTCOMPLEX(var1)
     PRINT*, ""

     PRINT*, "Your number/(3,4)"
     ans = var1 / var2
     CALL Put_INTCOMPLEX(ans)
     PRINT*, ""

! Intrinsics

     PRINT*, "REAL(3,4)"
     PRINT*, REAL(var2)
     PRINT*, ""

     PRINT*, "INT(3,4)"
     PRINT*, INT(var2)
     PRINT*, ""

     PRINT*, "AIMAG(3,4)"
     PRINT*, AIMAG(var2)
     PRINT*, ""

     PRINT*, "CONJG(3,4)"
     CALL Put_INTCOMPLEX(CONJG(var2))
     PRINT*, ""

     PRINT*, "ABS(3,4)"
     PRINT*, ABS(var2)

    END PROGRAM Testo
