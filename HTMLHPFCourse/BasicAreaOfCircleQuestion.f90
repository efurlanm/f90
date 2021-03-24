  DO
   PRINT*, "Type in the radius, a negative value will terminate"
   READ*, radius
   IF (radius .LT. 0) EXIT
    ... area calculation
    PRINT*, "Area of circle with radius ",&
            radius, " is ", area
    PRINT*, "Volume of sphere with radius ",&
            radius, " is ", volume
  END DO
  END
