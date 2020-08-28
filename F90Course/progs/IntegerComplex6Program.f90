    PROGRAM Testo
     USE Integer_Complex_Arithmetic
     IMPLICIT NONE
     TYPE(INTCOMPLEX) :: var1, var2, ans

     var1 = 3
     PRINT*, "var1 = 3"
     CALL Put_INTCOMPLEX(var1)

     var1 = 5.99
     PRINT*, "var1 = 5.99"
     CALL Put_INTCOMPLEX(var1)

     var1 = 6.01
     PRINT*, "var1 = 6.01"
     CALL Put_INTCOMPLEX(var1)

     var1 = Setup_INTCOMPLEX(1,2)
     var2 = Setup_INTCOMPLEX(3,4)

     PRINT*, "(1,2)+(3,4)"
     ans = var1 + var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(1,2)-(3,4)"
     ans = var1 - var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(1,2)/(3,4)"
     ans = var1 / var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(3,4)/(3,4)"
     ans = var2 / var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(3,4)/(1,2)"
     ans = var2 / var1
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(1,2)*(3,4)"
     ans = var1 * var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(1,2)**3"
     ans = var1 ** 3
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "+(1,2)"
     ans = +var1
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "-(1,2)"
     ans = -var1
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "Type in the two INTCOMPLEX components"
     CALL Get_INTCOMPLEX(var1)
     PRINT*, "This is what was typed in"
     CALL Put_INTCOMPLEX(var1)

     PRINT*, "Your number/(3,4)"
     ans = var1 / var2
     CALL Put_INTCOMPLEX(ans)

! Intrinsics

     PRINT*, "REAL(3,4)"
     PRINT*, REAL(var2)
     PRINT*, "INT(3,4)"
     PRINT*, INT(var2)
     PRINT*, "AIMAG(3,4)"
     PRINT*, AIMAG(var2)
     PRINT*, "CONJG(3,4)"
     CALL Put_INTCOMPLEX(CONJG(var2))
     PRINT*, "ABS(3,4)"
     PRINT*, ABS(var2)

! REAL | INTEGER .OP. INTCOMPLEX

     PRINT*, "2+(3,4)"
     ans =  2 + var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "2-(3,4)"
     ans =  2 - var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "2*(3,4)"
     ans =  2 * var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "2/(3,4)"
     ans =  2 /var2
     CALL Put_INTCOMPLEX(ans)

     var1 = Setup_INTCOMPLEX(1,2)
     PRINT*, "4/(1,2)"
     ans =  4/var1
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "2.5+(3,4)"
     ans =  2.5 + var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "2.5-(3,4)"
     ans =  2.5 - var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "2.5*(3,4)"
     ans =  2 * var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "2.5/(3,4)"
     ans =  2.5 /var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "4.7/(1,2)"
     ans =  4.7/var1
     CALL Put_INTCOMPLEX(ans)


     PRINT*, "-2.5+(3,4)"
     ans =  -2.5 + var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "-2.5-(3,4)"
     ans =  -2.5 - var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "-2.5*(3,4)"
     ans =  -2.5 * var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "-2.5/(3,4)"
     ans =  -2.5 /var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "-4.7/(1,2)"
     ans =  -4.7/var1
     CALL Put_INTCOMPLEX(ans)

! INTCOMPLEX .OP. INTEGER | REAL

     PRINT*, "(3,4)+2"
     ans =  var2 + 2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "3,4)-2"
     ans =  var2-2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(3,4) * 2"
     ans =  var2 * 2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(3,4)/2"
     ans =  var2/2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(1,2)/4"
     ans =  var1/4
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(3,4)+2.5"
     ans =  var2+2.5
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(3,4)-2.5"
     ans =  var2-2.5
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(3,4)*2.5"
     ans =   var2*2.5
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(3,4)/2.5"
     ans =  var2/2.5
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(1,2)/4.7"
     ans =  var1/4.7
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "-(3,4)-2.5"
     ans =   -var2-2.5
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "(3,4)*(-2.5)"
     ans =  var2*(-2.5)
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "0.99 * (3,4)"
     ans = 0.99 *var2
     CALL Put_INTCOMPLEX(ans)

     PRINT*, "1.0 * (3,4)"
     ans = 1.0 *var2
     CALL Put_INTCOMPLEX(ans)

! Extended precision

     var1 = Setup_INTCOMPLEX(3_short_int,1_long_int)
     PRINT*, "var1 = Setup_INTCOMPLEX(3_short_int,1_long_int)"
     CALL Put_INTCOMPLEX(var1)

     var1 = Setup_INTCOMPLEX(3_short_int,1_short_int)
     PRINT*, "var1 = Setup_INTCOMPLEX(3_short_int,1_short_int)"
     CALL Put_INTCOMPLEX(var1)

     var1 = Setup_INTCOMPLEX(3_long_int,1_short_int)
     PRINT*, "var1 = Setup_INTCOMPLEX(3_long_int,1_short_int)"
     CALL Put_INTCOMPLEX(var1)

     PRINT*, "var1 = Setup_INTCOMPLEX(3_long_int,1_long_int)"
     var1 = Setup_INTCOMPLEX(3_long_int,1_long_int)
     CALL Put_INTCOMPLEX(var1)

     PRINT*, "200_short_int * Setup_INTCOMPLEX(3_long_int,1_long_int)"
     ans = 200_short_int * var1
     CALL Put_INTCOMPLEX(ans)
     
     PRINT*, "Setup_INTCOMPLEX(3_long_int,1_long_int) - 20_short_int"
     ans = var1 - 20_short_int
     CALL Put_INTCOMPLEX(ans)
     
     PRINT*, "Setup_INTCOMPLEX(3_long_int,1_long_int) ** 200_short_int"
     ans = var1 ** 6_short_int
     CALL Put_INTCOMPLEX(ans)
     
     PRINT*, "var ** 6_long_int"
     ans = var1 ** 6_long_int
     CALL Put_INTCOMPLEX(ans)
     
     PRINT*, "var1 = Setup_INTCOMPLEX(30000_long_int,10000_long_int)"
     var1 = Setup_INTCOMPLEX(30000_long_int,10000_long_int)
     CALL Put_INTCOMPLEX(var1)

     PRINT*, "400_long_int / Setup_INTCOMPLEX(30000_long_int,10000_long_int)"
     ans = 400_long_int / var1
     CALL Put_INTCOMPLEX(ans)
     
     PRINT*, "Setup_INTCOMPLEX(30000_long_int,10000_long_int) / 4000000"
     ans = var1 / 4000000_long_int 
     CALL Put_INTCOMPLEX(ans)
     
    END PROGRAM Testo

