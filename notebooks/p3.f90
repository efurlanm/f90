implicit none
integer, parameter :: n = 6*10**8
real   , target    :: x(n)
real   , pointer   :: p1(:),p2(:),p3(:)
call random_number(x)
p1 => x
p2 => x
p3 => x
print*,sizeof(x),x(1),p1(1),p2(1),p3(1),x(n),p1(n),p2(n),p3(n)
end
