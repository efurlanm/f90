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
