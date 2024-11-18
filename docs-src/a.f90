
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
