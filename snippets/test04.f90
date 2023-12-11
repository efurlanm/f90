program main
    integer :: i, j, k, N=3
    real, dimension(3,3,3) :: a
    a = reshape([.50, .73, .22, .29, .65, .41, .69, .25, .76, .64, &
                 .60, .73, .93, .24, .63, .19, .73, .77, .93, .70, &
                 .29, .53, .34, .20, .91, .02, .47], &
                shape(a),order=[3,2,1])
    write(*,"(*(xg0.2))") (((a(k,j,:)), new_line('A'), &
                           j=1,N),new_line('A'),k=1,N)
    write(*,"(*(g0.2x))") a
end
