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
